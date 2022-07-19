src = $(wildcard r5/*.S) \
      $(wildcard r5/*.c) \
	  test.c dhry_1.c dhry_2.c
cflags = -fno-exceptions -mcpu=cortex-r5 -marm -mfloat-abi=hard -O3 -specs=nosys.specs -I r5 -T gcc.ld

bbai64_ip = 192.168.0.122
skam64x_ip = 192.168.0.151
clean:
	rm test.elf test.lst

test.elf: $(src)
	arm-none-eabi-gcc $(cflags) -o test.elf $(src)
	arm-none-eabi-size test.elf
	arm-none-eabi-objdump -xd test.elf > test.lst
	# sudo cp test.elf /lib/firmware/
	# sudo echo stop > /sys/class/remoteproc/remoteproc18/state
	# sudo echo test.elf > /sys/class/remoteproc/remoteproc18/firmware
	# sudo echo start > /sys/class/remoteproc/remoteproc18/state
	# sudo cat /sys/kernel/debug/remoteproc/remoteproc18/trace0

bbai64: test.elf
	scp test.elf debian@$(bbai64_ip):/lib/firmware
	ssh -t debian@$(bbai64_ip) 'sudo echo stop > /sys/class/remoteproc/remoteproc18/state ; \
		sudo echo test.elf > /sys/class/remoteproc/remoteproc18/firmware ; \
		sudo echo start > /sys/class/remoteproc/remoteproc18/state && \
		sudo cat /sys/kernel/debug/remoteproc/remoteproc18/trace0'

skam64x: test.elf
	scp test.elf root@$(skam64x_ip):/lib/firmware
	ssh root@$(skam64x_ip) 'echo stop > /sys/class/remoteproc/remoteproc2/state ; \
		echo test.elf > /sys/class/remoteproc/remoteproc2/firmware ; \
		echo start > /sys/class/remoteproc/remoteproc2/state && \
		cat /sys/kernel/debug/remoteproc/remoteproc2/trace0'
