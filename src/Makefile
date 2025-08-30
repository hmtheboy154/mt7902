# SPDX-License-Identifier: GPL-2.0-only
KVER ?= $(if $(KERNELRELEASE),$(KERNELRELEASE),$(shell uname -r))
KSRC ?= $(if $(KERNEL_SRC),$(KERNEL_SRC),/lib/modules/$(KVER)/build)
FWDIR := /lib/firmware/mediatek
JOBS ?= $(shell nproc --ignore=1)
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/mediatek/mt7902e
MT76DIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/mediatek/mt76

ifneq ("$(INSTALL_MOD_PATH)", "")
DEPMOD_ARGS = -b $(INSTALL_MOD_PATH)
else
DEPMOD_ARGS =
endif

#Handle the compression option for modules in 3.18+
ifneq ("","$(wildcard $(MT76DIR)/*.ko.gz)")
COMPRESS_GZIP := y
endif
ifneq ("","$(wildcard $(MT76DIR)/*.ko.xz)")
COMPRESS_XZ := y
endif
ifneq ("","$(wildcard $(MT76DIR)/*.ko.zst)")
COMPRESS_ZSTD := y
endif

obj-m += mt7902e.o

mt7902e-y := \
	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
	tx.o agg-rx.o mcu.o wed.o scan.o channel.o

mt7902e-y += \
	mt76_connac_mcu.o mt76_connac_mac.o mt76_connac3_mac.o

mt7902e-y += \
	mt792x_core.o mt792x_mac.o mt792x_trace.o \
	mt792x_debugfs.o mt792x_dma.o

mt7902e-y += \
	mt792x_acpi_sar.o

mt7902e-y += \
	mt7902/mac.o mt7902/mcu.o mt7902/main.o mt7902/init.o mt7902/debugfs.o mt7902/pci.o mt7902/pci_mac.o mt7902/pci_mcu.o

mt7902e-$(CONFIG_PCI) += pci.o
mt7902e-$(CONFIG_NL80211_TESTMODE) += testmode.o

CFLAGS_trace.o := -I$(src)
CFLAGS_mt792x_trace.o := -I$(src)

all:
	$(MAKE) -j$(JOBS) -C /lib/modules/$(KVER)/build/ M=`pwd` modules

clean:
	$(MAKE) -j$(JOBS) -C /lib/modules/$(KVER)/build/ M=`pwd` clean

install: all
	@install -D -m 644 -t $(MODDESTDIR) *.ko

ifeq ($(COMPRESS_GZIP), y)
	@gzip -f $(MODDESTDIR)/*.ko
endif
ifeq ($(COMPRESS_XZ), y)
	@xz -f -C crc32 $(MODDESTDIR)/*.ko
endif
ifeq ($(COMPRESS_ZSTD), y)
	@zstd -f -q --rm $(MODDESTDIR)/*.ko
endif

	@depmod $(DEPMOD_ARGS) -a $(KVER)

install_fw:
ifeq ($(wildcard $(FWDIR)), )
	@install -Dvm 644 -t $(FWDIR) firmware/*.bin
else
	@cp -r firmware tmp
ifneq ($(wildcard $(FWDIR)/*.zst), )
	@zstd -fq --rm tmp/*.bin
endif
ifneq ($(wildcard $(FWDIR)/*.xz), )
	@xz -f -C crc32 tmp/*.bin
endif
ifneq ($(wildcard $(FWDIR)/*.gz), )
	@gzip -f tmp/*.bin
endif
	@install -Dvm 644 -t $(FWDIR) tmp/*
	@rm -rf tmp
endif

uninstall:
	@for mod in $(MODLIST); do \
		rmmod -s $$mod || true; \
	done
	@rm -rf $(MODDESTDIR)
	@depmod $(DEPMOD_ARGS)
