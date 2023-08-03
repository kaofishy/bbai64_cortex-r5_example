APP ?= test.elf
APP_SOURCES ?= test.c
R_PROC ?= 18

CROSS_COMPILE ?= arm-none-eabi-

.PHONY: $(APP)

CROSS_CC ?= $(CROSS_COMPILE)gcc
CROSS_SIZE ?= $(CROSS_COMPILE)size
CROSS_OBJDUMP ?= $(CROSS_COMPILE)objdump

ARCH ?= r5

ifeq ($(ARCH),r5)
	CFLAGS += -mcpu=cortex-r5
endif

all: $(APP)

clean:
	rm -f $(APP)

rproc_clean:
	sudo echo stop > /sys/class/remoteproc/remoteproc$(R_PROC)/state
	sudo rm /lib/firmware/$(APP)

$(APP): $(APP_SOURCES) gcc.ld
	$(CROSS_CC) $(CFLAGS) -Og --specs=nosys.specs --specs=nano.specs -T gcc.ld -o $(APP) $(APP_SOURCES)
	$(CROSS_SIZE) $(APP)
	$(CROSS_OBJDUMP) -xd $(APP) > $(APP).lst

rproc_start:
	sudo cp $(APP) /lib/firmware/
	sudo echo $(APP) > /sys/class/remoteproc/remoteproc$(R_PROC)/firmware
	sudo echo start > /sys/class/remoteproc/remoteproc$(R_PROC)/state
	sudo cat /sys/kernel/debug/remoteproc/remoteproc$(R_PROC)/trace0

rproc_trace:
	sudo cat /sys/kernel/debug/remoteproc/remoteproc$(R_PROC)/trace0
