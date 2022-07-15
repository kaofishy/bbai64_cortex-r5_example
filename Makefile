test:
	arm-none-eabi-gcc -mcpu=cortex-r5 -Og --specs=nosys.specs --specs=nano.specs -T gcc.ld -o test.elf test.c
	arm-none-eabi-size test.elf
	arm-none-eabi-objdump -xd test.elf > test.lst
	# sudo cp test.elf /lib/firmware/
	# sudo echo stop > /sys/class/remoteproc/remoteproc18/state
	# sudo echo test.elf > /sys/class/remoteproc/remoteproc18/firmware
	# sudo echo start > /sys/class/remoteproc/remoteproc18/state
	# sudo cat /sys/kernel/debug/remoteproc/remoteproc18/trace0