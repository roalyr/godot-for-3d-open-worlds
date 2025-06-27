#!/bin/sh

# For windows
export MINGW_PREFIX="$HOME/Buildroot/llvm-mingw-20250613-ucrt-ubuntu-22.04-x86_64"

# For incremental
#export SCONS_CACHE="./scons_cache/godot_4_scons_cache_windows";
#mkdir -p $SCONS_CACHE
mkdir -p "./logs"

${MINGW_PREFIX}/bin/x86_64-w64-mingw32-gcc --version


	echo
	echo "          ==============================================="
	echo "          |        BUILDING WINDOWS x86-64 64 bit       |"
	echo "          ==============================================="
	echo

# Editor (tools)
scons -j2 platform=windows use_llvm=yes precision=double arch=x86_64 2>&1 | tee ./logs/godot_4_scons_windows_64_tools_build.txt;

# Template(s)
scons -j2 platform=windows use_llvm=yes precision=double target=template_debug arch=x86_64 2>&1 | tee ./logs/godot_4_scons_windows_64_template_build.txt;

# Removing debug symbols
#strip ./bin/godot.windows.opt.tools.64.exe
#strip ./bin/godot.windows.opt.debug.64.exe

	echo
	echo "          ==============================================="
	echo "          |     DONE BUILDING WINDOWS x86-64 64 bit     |"
	echo "          ==============================================="
	echo
