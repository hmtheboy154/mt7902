# SPDX-License-Identifier: GPL-2.0

# 1. Force enable requested features via C preprocessor flags.
# This ensures the features are compiled into your OOT module regardless of the host kernel's .config.
ccflags-y += -DCONFIG_BT_HCIBTUSB_AUTOSUSPEND=1
ccflags-y += -DCONFIG_BT_HCIBTUSB_POLL_SYNC=1
ccflags-y += -DCONFIG_BT_HCIBTUSB_MTK=1
ccflags-y += -DCONFIG_BT_MTK=1

# 2. Define the target modules to build (ignoring SDIO, Intel, Broadcom, etc.) 
obj-m += btusb_mt7902.o
btusb_mt7902-y += btusb.o btmtk.o
