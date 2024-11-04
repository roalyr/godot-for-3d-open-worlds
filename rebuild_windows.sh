#!/bin/sh

# For windows
export MINGW32_PREFIX="/usr/bin/i686-w64-mingw32-"
export MINGW64_PREFIX="/usr/bin/x86_64-w64-mingw32-"

# For incremental
export SCONS_CACHE="./scons_cache/scons_cache_windows";
mkdir -p $SCONS_CACHE
mkdir -p "./logs"

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
scons -j2 tools=yes target=release_debug platform=windows debug_symbols=no bits=64 2>&1 | tee ./logs/scons_windows_64_tools_build.txt;

# Template(s)
scons -j2 tools=no target=release_debug platform=windows debug_symbols=no bits=64 2>&1 | tee ./logs/scons_windows_64_debug_build.txt;


	echo
	echo "          ==============================================="
	echo "          |     DONE BUILDING WINDOWS x86-64 64 bit     |"
	echo "          ==============================================="
	echo
