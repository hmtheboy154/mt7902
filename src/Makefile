# SPDX-License-Identifier: GPL-2.0

# 1. Force enable requested features via C preprocessor flags.
# This ensures the features are compiled into your OOT module regardless of the host kernel's .config.
ccflags-y += -DCONFIG_BT_HCIBTUSB_AUTOSUSPEND=1
ccflags-y += -DCONFIG_BT_HCIBTUSB_POLL_SYNC=1
ccflags-y += -DCONFIG_BT_HCIBTUSB_MTK=1
ccflags-y += -DCONFIG_BT_MTK=1

# Enable UART specific dependencies for MTK (Serdev and H4 protocol)
ccflags-y += -DCONFIG_BT_HCIUART_SERDEV=1
ccflags-y += -DCONFIG_BT_HCIUART_H4=1
ccflags-y += -DCONFIG_BT_HCIUART_BCSP=1
ccflags-y += -DCONFIG_BT_HCIUART_LL=1
ccflags-y += -DCONFIG_BT_HCIUART_3WIRE=1

# 2. Define the target modules to build (ignoring SDIO, Intel, Broadcom, etc.) 
obj-m += btusb_mt7902.o
btusb_mt7902-y += btusb.o btmtk.o btmtkuart.o hci_uart.o

# 3. Assemble the hci_uart module from its required components
btusb_mt7902-y := hci_ldisc.o
btusb_mt7902-y += hci_serdev.o
btusb_mt7902-y += hci_h4.o
btusb_mt7902-y += hci_h5.o
btusb_mt7902-y += hci_bcsp.o
btusb_mt7902-y += hci_ll.o
# Should be unused, but we have to build them in for hci_uart
btusb_mt7902-y += hci_ath.o hci_intel.o hci_bcm.o hci_qca.o hci_ag6xx.o hci_mrvl.o hci_aml.o
