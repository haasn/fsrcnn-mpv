module Main (main) where

import Control.Monad
import Text.Printf
import Data.List
import Data.List.Split
import Data.Traversable

-- main = generateShader 4 2 1
--     [w1, w2, w3, w4, w5]
--     [b1, b2, b3, b4, b5]
--     [alpha1, alpha2, alpha3, alpha4]

-- main = generateShader 4 4 4
--     [w1, w2, w3, w4, w5, w6, w7, w8]
--     [b1, b2, b3, b4, b5, b6, b7, b8]
--     [alpha1, alpha2, alpha3, alpha4, alpha5, alpha6, alpha7]

main = generateShader 24 4 4
    [w1, w2, w3, w4, w5, w6, w7, w8]
    [b1, b2, b3, b4, b5, b6, b7, b8]
    [alpha1, alpha2, alpha3, alpha4, alpha5, alpha6, alpha7]

generateShader :: Int -> Int -> Int -> [[Double]] -> [[Double]] -> [[Double]] -> IO ()
generateShader s d m weights biases alphas | s`mod`4 == 0 && d <= 4 = do

    let numLayers   = [0 .. s `div` 4 - 1]
        params      = transpose [weights, biases, alphas]
        features p  = forM_ numLayers $ \i -> featureLayer   i $ map (slice s 4 i) p
        expansion p = forM_ numLayers $ \i -> expansionLayer i $ map (slice s 4 i) p
        mapping     = map mappingLayer [1..m]

        layers :: [[[Double]] -> IO ()]
        layers = [features, shrinkLayer] ++ mapping ++ [expansion, deconvLayer]

        featureLayer i [ws,bs,as] = do
            header ["LUMA"] ("FEATURE"++show i) 4 bs ("feature map "++show i)
            convolve 2 1 4 ws "LUMA"
            preluFooter 4 as

        shrinkLayer [ws,bs,as] = do
            header (map (mappend "FEATURE" . show) numLayers) "MODEL" d bs "shrinking"
            forM_ numLayers $ \i -> convolve 0 4 d (drop (4*d*i) ws) $ "FEATURE"++show i
            preluFooter d as

        mappingLayer i [ws,bs,as] = do
            header ["MODEL"] "MODEL" d bs ("mapping "++show i)
            convolve 1 d d ws "MODEL"
            preluFooter d as

        expansionLayer i [ws,bs,as] = do
            header ["MODEL"] ("EXPANDED"++show i) 4 bs ("expansion "++show i)
            convolve 0 d 4 ws "MODEL"
            preluFooter 4 as

        deconvLayer [ws,bs] = do
            put "//!WIDTH LUMA.w 3 *"
            put "//!HEIGHT LUMA.h 3 *"
            header (map (mappend "EXPANDED" . show) numLayers) "LUMA" 1 bs "reconstruction"
            put "vec2 fcoord = fract(EXPANDED0_pos * EXPANDED0_size);"
            put "vec2 base = EXPANDED0_pos + (vec2(0.5) - fcoord) * EXPANDED0_pt;"
            put "ivec2 index = 2 - ivec2(fcoord * vec2(3));"
            forM_ numLayers $ \i -> convolve_trans 4 (slice s 4 i ws) $ "EXPANDED"++show i
            put "return vec4(res, 0, 0, 1);"
            put "}"

    sequence_ $ zipWith ($) layers params

put :: PrintfType r => String -> r
put f = printf (f ++ "\n")

vec :: Int -> String
vec 1 = "float"
vec n = printf "vec%d" n

mat :: Int -> Int -> String
mat 1 m = vec m
mat _ 1 = error "use a dot product instead of a matrix multiplication!"
mat n m | n == m = printf "mat%d" n
        | n /= m = printf "mat%dx%d" n m

fill :: [Double] -> String
fill = intercalate "," . map show

-- slices N components at offset I out of a total of T components
slice :: Int -> Int -> Int -> [Double] -> [Double]
slice t n i = concat . map (take n . drop (n*i)) . chunksOf t

header :: [String] -> String -> Int -> [Double] -> String -> IO ()
header srcTexen dstTex o bias desc = do
    put "//!HOOK LUMA"
    put "//!DESC %s" desc
    forM_ srcTexen $ \s -> put "//!BIND %s" s
    put "//!SAVE %s" dstTex
    put "//!COMPONENTS %d" o
    put ""
    put "vec4 hook()"
    put "{"
    put "%s res = %s(%s);" (vec o) (vec o) (fill bias)

preluFooter :: Int -> [Double] -> IO ()
preluFooter o alpha = do
    put "res = mix(res, %s(%s) * res, lessThan(res, %s(0.0)));"
         (vec o) (fill alpha) (vec o)

    put "return vec4(res%s);" . concat $ replicate (4-o) ", 0.0"
    put "}\n"


-- generate radius N convolution with I input components and O output components,
convolve :: Int -> Int -> Int -> [Double] -> String -> IO ()
convolve n i o weights srcTex = do
    let ws = chunksOf (i*o) weights `zip` replicateM 2 [-n .. n]
    forM_ ws $ \(w, [x,y]) -> do
        put "res += %s(%s) * %s(%s_texOff(vec2(%d,%d)));"
             (mat i o) (fill w) (vec i) srcTex x y

-- generate 9x9 convolution transpose for ratio 3.0 with I input components.
-- weights are arranged as they would be for the convolution
convolve_trans :: Int -> [Double] -> String -> IO ()
convolve_trans i weights srcTex = do
    let -- we need to reverse everything because we're moving in the opposite
        -- direction of the corresponding convolution
        vecs    = reverse $ chunksOf i weights
        -- group everything into 3x3 regions that collapse down to the same
        -- sample
        columns = chunksOf 3 . chunksOf 3 $ vecs
        blocks  = chunksOf 3 . concat $ transpose columns

    let ws = blocks `zip` replicateM 2 [-1 .. 1 :: Int]
    forM_ ws $ \([l,m,r], [y,x]) -> do
        put "res += dot(%s[](" (vec i)
        let vs = map (\v -> printf "%s(%s)" (vec i) (fill v)) $ l++m++r
        put $ intercalate ",\n" vs
        put ")[index.x * 3 + index.y], %s_tex(base + %s_pt * vec2(%d, %d)));"
            srcTex srcTex x y

{- generates slower code

deconvolve_v2 :: Int -> [Double] -> String -> IO ()
deconvolve_v2 i weights srcTex = do
    let vecs    = reverse $ chunksOf i weights
        columns = chunksOf 3 . chunksOf 3 $ vecs
        blocks  = chunksOf 3 . concat $ transpose columns

    let ws = blocks `zip` replicateM 2 [-1 .. 1 :: Int]

    forM_ (replicateM 2 [0,1,2 :: Int]) $ \[ix,iy] -> do
        put "if (index.x == %d && index.y == %d) {" ix iy
        forM_ ws $ \(vs, [y,x]) -> do
            let v = (vs !! ix) !! iy
            put "res += dot(%s(%s), %s_tex(base + %s_pt * vec2(%d, %d)));"
                (vec i) (fill v) srcTex srcTex x y
        put "} else"
-}
