# MediaTek MT7902 Linux Driver (Backport)

Backport for **MT7902** WiFi on older kernels. Tested on kernels 6.17-6.19.

---

### 1. Install Requirements
```bash
sudo apt update
sudo apt install build-essential git linux-headers-$(uname -r)
```

### 2. Build and Install
```bash
make -j$(nproc)
sudo make install install_fw -j$(nproc)
sudo depmod -a
```

### 4. Load Driver
Unloads the default driver and load the backport.
```bash
sudo modprobe -r mt76
sudo modprobe mt7902e
```

### 5. Verify
```bash
lsmod | grep mt7902e
sudo dmesg | grep -i mt7902
```
