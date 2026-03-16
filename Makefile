# SPDX-License-Identifier: GPL-2.0-only
KVER ?= $(if $(KERNELRELEASE),$(KERNELRELEASE),$(shell uname -r))
KSRC ?= $(if $(KERNEL_SRC),$(KERNEL_SRC),/lib/modules/$(KVER)/build)
FWDIR := /lib/firmware/mediatek
JOBS ?= $(shell nproc --ignore=1)
MODNAME := mt7902e
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/mediatek/$(MODNAME)
MT76DIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/mediatek/mt76

ifneq ("$(INSTALL_MOD_PATH)", "")
DEPMOD_ARGS = -b $(INSTALL_MOD_PATH)
else
DEPMOD_ARGS =
endif

ifneq ("","$(wildcard $(MT76DIR)/*.ko.gz)")
COMPRESS_GZIP := y
endif
ifneq ("","$(wildcard $(MT76DIR)/*.ko.xz)")
COMPRESS_XZ := y
endif
ifneq ("","$(wildcard $(MT76DIR)/*.ko.zst)")
COMPRESS_ZSTD := y
endif

export COMPRESS_GZIP COMPRESS_XZ COMPRESS_ZSTD

# The directory containing the actual source code and kbuild Makefile
SRC_DIR := $(shell pwd)/src

all:
	$(MAKE) -j$(JOBS) -C $(KSRC) M=$(SRC_DIR) modules
	@cp -v $(SRC_DIR)/*.ko .

clean:
	$(MAKE) -j$(JOBS) -C $(KSRC) M=$(SRC_DIR) clean
	@rm -vf *.ko

install: all
	@install -vDm 644 -t $(MODDESTDIR) *.ko
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
	@install -vDm 644 -t $(FWDIR) firmware/*.bin
else
	@cp -vr firmware tmp
ifneq ($(wildcard $(FWDIR)/*.zst), )
	@zstd -fq --rm tmp/*.bin
endif
ifneq ($(wildcard $(FWDIR)/*.xz), )
	@xz -f -C crc32 tmp/*.bin
endif
ifneq ($(wildcard $(FWDIR)/*.gz), )
	@gzip -f tmp/*.bin
endif
	@install -vDm 644 -t $(FWDIR) tmp/*
	@rm -vrf tmp
endif

uninstall:
	@echo "Unloading module"
	@rmmod -v $(MODNAME) || true
	@rm -vrf $(MODDESTDIR)
	@depmod $(DEPMOD_ARGS)

uninstall_fw:
	@rm -vrf $(FWDIR)/WIFI_MT7902_patch_mcu_1_1_hdr.bin.*
	@rm -vrf $(FWDIR)/WIFI_RAM_CODE_MT7902_1.bin.*
