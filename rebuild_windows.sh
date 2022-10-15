#!/bin/sh

# For windows
export MINGW32_PREFIX="/usr/bin/i686-w64-mingw32-"
export MINGW64_PREFIX="/usr/bin/x86_64-w64-mingw32-"

# For incremental
export SCONS_CACHE="./scons_cache/scons_cache_windows";
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

# Editor (tools)
scons -j1 tools=yes target=release_debug debug_symbols=no platform=windows bits=64 2>&1 | tee ./logs/scons_windows_tools_build.txt;
# Template(s)
scons -j1 tools=no target=release_debug debug_symbols=no platform=windows bits=64 2>&1 | tee ./logs/scons_windows_debug_build.txt;

# Removing debug symbols
strip ./bin/godot.windows.*
