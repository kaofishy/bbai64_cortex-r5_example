# (Extremely) Minimal Cortex-R5 remoteproc example for Beaglebone AI-64

Cortex-R5 "Hello World" on Beaglebone AI-64, showing how to initialize a minimal remoteproc resource table with a working trace log. Be warned that this is only a proof-of-concept, and includes just enough code to get *something* up and running on the Cortex-R5 (meaning no initialization code for interrupts, cache, MPU, RAT, etc...)

To compile this example, you need the arm-none-eabi gcc toolchain installed on your system.

https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/downloads

If you were compiling this directly on the Beaglebone AI-64, you can uncomment the commented lines in the Makefile to run the example. If everything worked you should see "Hello world!" printed from the remoteproc trace log.
