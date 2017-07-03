## gen.hs

This generates the shader files, based on weights exported by FSRCNN-TensorFlow

## FSRCNN_4_2_1.glsl

A proof-of-concept shader with a low network size: (s,d,m) = (4,2,1). Mostly
there for testing, because it's much easier to test on such a low network
size.

## FSRCNNi_4_2_1_v2.glsl

Same as FSRCNN_4_2_1.glsl, but uses a direct nearest neighbour texture lookup
for the 3x3 convolution instead of an immediate constant reference. In theory,
this could be faster for AMD GPUs, but for nvidia it seems to be slower.
Requires a branch of mpv which is on my computer.
