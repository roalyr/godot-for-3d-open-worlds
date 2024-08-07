#!/bin/sh

# x86-64
sh ./rebuild_linux_x86_64_buildroot.sh

# i686 32 bit
sh ./rebuild_linux_x86_32_buildroot.sh

# ARM 64 bit
sh ./rebuild_linux_arm64_buildroot.sh

# ARM 32 bit
sh ./rebuild_linux_arm32_buildroot.sh

# Windows 64 bit
sh ./rebuild_windows.sh

# Android armv7 and aarch64
sh ./rebuild_android.sh
