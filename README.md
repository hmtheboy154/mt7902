# btusb_mt7902

This is basically the mainline version of btusb & btmtk with [patches to support MT7902](https://lore.kernel.org/all/20260219231624.8226-1-sean.wang@kernel.org/) & firmware provided by Mediatek. I stripped down all the unnecessary files & other hardware support to ensure only MT7902 card is supported.

> [!CAUTION]
> [Kernel 7.1](https://kernel.org/) has added official support for MT7902 bluetooth and wifi, it's recommended to use their official driver instead and **follow the instructions clearly** on [bugzilla.kernel.org](https://bugzilla.kernel.org/)'s homepage when reporting problems.

> [!WARNING]
> This out-of-tree driver only support the PCIe version of MT7902, for SDIO support it's better if you just merge Mediatek patches on your own !

> [!TIP]
> For WIFI support, check out [this branch](https://github.com/hmtheboy154/mt7902/tree/backport).


## Status

The driver supports kernel 6.6~6.19 (and might be 7.0 soon) and is usable according to users reported in this [spreadsheet](https://docs.google.com/spreadsheets/d/1G2mQEeLQAu4oB85G-y4A9OduA1ZP0rUcY-b6MRnZhFU/edit?usp=drive_link&pli=1&authuser=0). 

## Installation

> [!IMPORTANT]
> Before building & installing this driver, remember to install essential packages to build a kernel driver like linux kernel's headers & toolchain. I will not cover it here.

- Get the source using `git`

```bash
git clone https://github.com/hmtheboy154/mt7902 -b bluetooth_backport btusb_mt7902
cd btusb_mt7902
```

- To only build the driver, use this command

```bash
make -j$(nproc)
```

- To build the driver & install it:

```bash
sudo make install -j$(nproc)
```

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

## Note

`btusb` and `btmtk` conflict with `btusb_mt7902`, unload them if loading `btusb_mt7902` presents an error.

You can blacklist them by putting this in `/etc/modprobe.d/blacklist_btusb.conf`:
```
blacklist btusb btmtk
```

## Feedback

If you have any issue using this driver, please provide feedback in this [Discord group](https://discord.gg/JGhjAxEFhz).
