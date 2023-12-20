#!/bin/sh

# For windows
export MINGW32_PREFIX="/usr/bin/i686-w64-mingw32-"
export MINGW64_PREFIX="/usr/bin/x86_64-w64-mingw32-"

# For incremental
export SCONS_CACHE="./scons_cache/godot_4_scons_cache_windows";
mkdir -p $SCONS_CACHE

${MINGW32_PREFIX}gcc --version
${MINGW64_PREFIX}gcc --version

# Cross-compiling from some Ubuntu versions may lead to this bug, 
# due to a default configuration lacking support for POSIX threading.
# You can change that configuration following those instructions, for 64-bit:
#
#   sudo update-alternatives --config x86_64-w64-mingw32-gcc
#   <choose x86_64-w64-mingw32-gcc-posix from the list>
#   sudo update-alternatives --config x86_64-w64-mingw32-g++
#   <choose x86_64-w64-mingw32-g++-posix from the list>

	echo
	echo "          ==============================================="
	echo "          |        BUILDING WINDOWS x86-64 64 bit       |"
	echo "          ==============================================="
	echo

# Editor (tools)
scons -j2 platform=windows precision=double 2>&1 | tee ./logs/godot_4_scons_windows_64_tools_build.txt;

# Template(s)
scons -j2 platform=windows precision=double target=template_debug arch=x86_64 2>&1 | tee ./logs/godot_4_scons_windows_64_template_build.txt;
# scons -j2 platform=windows precision=double target=template_release arch=x86_64 2>&1 | tee ./logs/godot_4_scons_windows_64_template_release_build.txt;

# Removing debug symbols
#strip ./bin/godot.windows.opt.tools.64.exe
#strip ./bin/godot.windows.opt.debug.64.exe

	echo
	echo "          ==============================================="
	echo "          |     DONE BUILDING WINDOWS x86-64 64 bit     |"
	echo "          ==============================================="
	echo
