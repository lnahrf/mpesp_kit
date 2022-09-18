# mpespkit
MicroPython ESP Toolkit v1.0.0

***mpespkit*** is a MicroPython management CLI toolkit for ESP32 type devices. I created the tool for my own personal use, and decided to release it as open-source software because it might be helpful to someone, somewhere.

## Tools 

- Flash - Used to flash a new MicroPython firmware on to the device
- Transfer - Used to transfer files into MicroPython's file system
- File List - Used to list all files on MicroPython's file system
- Delete - Used to delete a file or files from MicroPython's file system
- Soft Reset - Used to send a soft reset signal to the device

## Dependencies
- Python 3 - Make sure Python 3 is installed and is a valid command
- esptool - Make sure esptool is installed, run `pip install esptool`
- adafruit-ampy - Make sure adafruit-ampy is installed and that `ampy` is a valid command, run `pip install adafruit-ampy`


## Drivers
You can download the USB drivers necessary for ESP32 devices from the following URL

Windows/MacOS - https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers?tab=downloads

Choose the right version from the download list, download and install. Debian Linux already comes with the driver installed (tested on Ubuntu 20.04).

***Without the drivers installed your COM port won't show up on mpespkit.***

## Issues
There is a known issue with scripts idling (never ending) from time to time, but these can be easily solved by reconnecting the physical device and running the script again. I will work on finding a software solution for this issue in the near future.

 - **The executable won't work properly if your micro-usb cable doesn't support data transfer.**
 - **The executable won't work properly if run by a superuser (no sudo).**
 
 If you find a bug, please open an issue in this repository.

## Compile from source

If you wish to compile the executable from source, make sure you have the Dart SDK installed (v2.18.1+) and then clone the repository by running

```bash
git clone https://github.com/tk-ni/mpespkit.git
```

Cd into the directory with `cd mpespkit` and then run
```bash
mkdir build
dart compile exe bin/mpespkit.dart -o build/mpespkit
# dart compile exe will compile the right executable for the current OS
```
Give the binary executable permissions with 
```bash
chmod +x build/mpespkit
```

And you're done!
