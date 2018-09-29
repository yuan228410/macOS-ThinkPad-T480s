# macOS on Lenovo ThinkPad T480s

This repository contains a sample configuration to run macOS (Currently Mojave `10.14`) on a Lenovo ThinkPad T480s

## Used Hardware Configuration

- Lenovo ThinkPad T480s
  - Intel i5-8250U
  - 8GB RAM onboard + Crucial DDR4 2400-SODIMM
  - Samsung 970 evo NVMe SSD
  - Dell DW1560 Wireless (original Intel AC8265 not working)
    - Wi-Fi device ID [`14e4:43b1`], shows as Apple Airport Extreme due to `FakePCIID_Broadcom_WiFi.kext`
    - Bluetooth device ID [`0a5c:216f`], chipset `20702A3` with firmware `v14 c5882` using `BrcmPatchRAM2.kext`
  - Realtek ALC257 using `VoodooHDA.kext` temporarily, `AppleALC.kext` [not working][t480] (though [layout 11 codec][layout11] is correct)
  - Intel UHD Graphics 620 (Nvidia MX150 disabled, Optimus not supported by macOS)
  - Power management and battery status by ACPI hotpatching
  - Integrated camera (works out of the box)
  - Keyboard/Elan Touchpad (PS/2) using `ApplePS2SmartTouchPad.kext` v4.7b5 by EMlyDinEsH
    - Support multi-touch gestures
    - Need to disable Trackpoint in BIOS (otherwise touchpad would be disconnected)
    - Requires to patch the binary `ApplePS2SmartTouchPad`, already patched in this repo (otherwise the driver reports unsupported model):
      ```
      Offset    Original  Patched
      0000ABF5  72        EB
      0000AC2D  01        04
      ```
- Disabled devices
  - WWAN (no module)
  - Trackpoint (can be enabled when using `VoodooPS2Controller.kext`)
- Untested devices
  - SD card reader
  - Fingerprint scanner
  - Thunderbolt 3 (USB type-c works)
- Firmware Revisions
  - BIOS version `1.25`

## Preparation

* (**Important**) Copy `EFI/CLOVER/config.example.plist` to `config.plist`. Edit SMBIOS entry in `config.plist` to work properly:
  - `BoardSerialNumber`: Change any `Z` to random letters or numbers
  - `Memory -> Modules`: Fill in the correct size for your RAM in `Size`, e.g. `4096` for 4GB, `8192` for 8GB
  - `SerialNumber`: Change any `Z` to random letters or numbers
  - `SmUUID`: Generate a unique UUID by `uuidgen` or simply using an [online service][uuid]
* All SSDT hotpatches are located at `EFI/CLOVER/ACPI/dsl`. You can update the compiled `.aml` binaries by running `update.sh` (macOS) or `update.bat` (Windows).
* The `SSDT-KBD.aml` is tuned for `ApplePS2SmartTouchPad.kext`. If you want to switch to `VoodooPS2Controller.kext`, use `SSDT-KBD.aml` in `backup` folder instead.

## Credits

- [OS-X-Clover-Laptop-Config (Hot-patching)](https://github.com/RehabMan/OS-X-Clover-Laptop-Config)
- [Dell XPS 13 9360 Guide](https://github.com/the-darkvoid/XPS9360-macOS)
- [ThinkPad X1 Carbon Gen 6 Guide](https://github.com/tylernguyen/x1c6-hackintosh)

[t480]: https://www.hackintosh-forum.de/index.php/Thread/37614-Lenovo-T480/?postID=434080#post434080
[layout11]: https://github.com/acidanthera/AppleALC/tree/master/Resources/ALC257
[clover]: https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/
[uuid]: https://www.uuidgenerator.net/