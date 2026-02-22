# MediaTek MT7902 Linux Driver (Backport)

Backport for **MT7902** WiFi on older kernels. Tested on kernels 6.17-6.19.

---

### 1. Install Requirements
```bash
sudo apt update
sudo apt install build-essential git linux-headers-$(uname -r) dkms
```

### 2. Build and Install
```bash
sudo mkdir -p /usr/src/mt7902e-0.1
sudo cp -r * /usr/src/mt7902e-0.1
sudo dkms add -m mt7902e -v 0.1
sudo dkms build -m mt7902e -v 0.1
sudo dkms install -m mt7902e -v 0.1
sudo make install install_fw -j$(nproc)
```

### 4. Load Driver
```bash
sudo modprobe mt7902e
```

### 5. Verify
```bash
lsmod | grep mt7902e
sudo dmesg | grep -i mt7902
```
