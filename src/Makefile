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
