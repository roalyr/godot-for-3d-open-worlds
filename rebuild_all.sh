#!/bin/sh

# x86-64
sh ./rebuild_linux_64_buildroot.sh

# i686 32 bit
sh ./rebuild_linux_32_buildroot.sh

# ARM 32 bit
sh ./rebuild_linux_armv8_buildroot.sh

# Windows 64 bit
sh ./rebuild_windows.sh

# Android armv7 and aarch64
sh ./rebuild_android.sh