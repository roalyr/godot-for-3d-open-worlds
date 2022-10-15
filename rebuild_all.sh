#!/bin/sh

# x86-64
sh ./rebuild_linux_64_buildroot.sh

# i686 32 bit, rename binaries
sh ./rebuild_linux_32_buildroot.sh
# mv ./bin/godot.x11.opt.tools.32 ./bin/godot.x11.opt.tools.i686
# mv ./bin/godot.x11.opt.debug.32 ./bin/godot.x11.opt.debug.i686

# ARM 32 bit, rename binaries
# sh ./rebuild_linux_arm_buildroot.sh
# mv ./bin/godot.x11.opt.tools.32 ./bin/godot.x11.opt.tools.arm
# mv ./bin/godot.x11.opt.debug.32 ./bin/godot.x11.opt.debug.arm

# Windows 64 bit
sh ./rebuild_windows.sh

# Android armv7 and aarch64
sh ./rebuild_android.sh