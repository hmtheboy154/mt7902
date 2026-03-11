# mt7902e

This is basically the mainline version of mt76 with [patches to support MT7902](https://lore.kernel.org/all/20260219004007.19733-1-sean.wang@kernel.org/) & firmware provided by Mediatek. I also stripped down all the unnecessary files & other hardware support to ensure only MT7902 card is supported.

> [!WARNING]
> This out-of-tree driver only support the PCIe version of MT7902, for SDIO support it's better if you just merge Mediatek patches on your own !

> [!TIP]
> For Bluetooth support, check out [this branch](https://github.com/hmtheboy154/mt7902/tree/bluetooth_backport).


## Status

The driver supports kernel 6.6~6.19 (and might be 7.0 soon) and is usable according to users reported in this [spreadsheet](https://docs.google.com/spreadsheets/d/1G2mQEeLQAu4oB85G-y4A9OduA1ZP0rUcY-b6MRnZhFU/edit?usp=drive_link&pli=1&authuser=0). 

## Installation

> [!IMPORTANT]
> Before building & installing this driver, remember to install essential packages to build a kernel driver like linux kernel's headers & toolchain. I will not cover it here.

- Get the source using `git`

```bash
git clone https://github.com/hmtheboy154/mt7902
cd mt7902
```

- To only build the driver, use this command

```bash
make -j$(nproc)
```

- To build the driver & install it:

```bash
sudo make install -j$(nproc)
```

> [!TIP]
> As per the [20260309](https://gitlab.com/kernel-firmware/linux-firmware#linux-firmware) release, the firmware should be already provided by your distribution, for Debian as of present, check in the unstable repo.

- To install the firmware required for the driver:

```bash
sudo make install_fw
```

- To remove the driver:

```bash
sudo make uninstall
```

- To remove the firmware:

```bash
sudo make uninstall_fw
```

Once you got the driver & firmware installed, reboot to see changes.

## Feedback

If you have any issue using this driver, please provide feedback in this [Discord group](https://discord.gg/JGhjAxEFhz).
