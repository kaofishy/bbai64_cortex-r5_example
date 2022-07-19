# Cortex-R5 Dhrystone on DDR memory with MPU and cache for Beaglebone AI-64

Cortex-R5 Dhrystone example on Beaglebone AI-64, showing how to initialize a remoteproc resource table with a working trace log, and boot code to enable the FPU as well as initialize the MPU and cache to run code from DDR memory.

To compile this example, you need the arm-none-eabi gcc toolchain installed on your system.

https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/downloads

If you were compiling this directly on the Beaglebone AI-64, you can uncomment the commented lines in the Makefile to run the example. If everything worked you should see the Dhrystone results printed from the remoteproc trace log.

Otherwise, upload `test.elf` to `/lib/firmware/` on the AI-64, then type in the following commands as root:
```
echo stop > /sys/class/remoteproc/remoteproc18/state
echo test.elf > /sys/class/remoteproc/remoteproc18/firmware
echo start > /sys/class/remoteproc/remoteproc18/state
cat /sys/kernel/debug/remoteproc/remoteproc18/trace0
```
You should now see the Dhrystone results similar to this:
```
Dhrystone Benchmark, Version 2.1 (Language: C)

Program compiled without 'register' attribute

Execution starts, 100000 runs through Dhrystone
Execution ends

Final values of the variables used in the benchmark:

Int_Glob:            5
        should be:   5
Bool_Glob:           1
        should be:   1
Ch_1_Glob:           A
        should be:   A
Ch_2_Glob:           B
        should be:   B
Arr_1_Glob[8]:       7
        should be:   7
Arr_2_Glob[8][7]:    100010
        should be:   Number_Of_Runs + 10
Ptr_Glob->
  Ptr_Comp:          -1508836712
        should be:   (implementation-dependent)
  Discr:             0
        should be:   0
  Enum_Comp:         2
        should be:   2
  Int_Comp:          17
        should be:   17
  Str_Comp:          DHRYSTONE PROGRAM, SOME STRING
        should be:   DHRYSTONE PROGRAM, SOME STRING
Next_Ptr_Glob->
  Ptr_Comp:          -1508836712
        should be:   (implementation-dependent), same as above
  Discr:             0
        should be:   0
  Enum_Comp:         1
        should be:   1
  Int_Comp:          18
        should be:   18
  Str_Comp:          DHRYSTONE PROGRAM, SOME STRING
        should be:   DHRYSTONE PROGRAM, SOME STRING
Int_1_Loc:           5
        should be:   5
Int_2_Loc:           13
        should be:   13
Int_3_Loc:           7
        should be:   7
Enum_Loc:            1
        should be:   1
Str_1_Loc:           DHRYSTONE PROGRAM, 1'ST STRING
        should be:   DHRYSTONE PROGRAM, 1'ST STRING
Str_2_Loc:           DHRYSTONE PROGRAM, 2'ND STRING
        should be:   DHRYSTONE PROGRAM, 2'ND STRING

Microseconds for one run through Dhrystone: 0.286091 
Dhrystones per Second:                      3495392.750000 
```

This Dhrystones per Second works out to be about 1.9 DMIPS/MHz on the 1GHz Cortex-R5, which is achieved by enabling cache and all GCC optimizations.
