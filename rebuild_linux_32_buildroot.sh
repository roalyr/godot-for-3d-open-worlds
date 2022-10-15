#!/bin/sh

# For incremental
export SCONS_CACHE="./scons_cache/scons_cache_x11_32";
mkdir -p $SCONS_CACHE

# Reference buildroot and see if scons is used from there
BUILDROOT_PATH="/home/roalyr/Buildroot/i686-godot-linux-gnu_sdk-buildroot/bin"
PATH=$BUILDROOT_PATH:$PATH 
WHICHSCONS=$(which scons)

if [ "${BUILDROOT_PATH}/scons" = $WHICHSCONS ]
then
	echo
	echo "          ==============================================="
	echo "          |            USING BUILDROOT 32 bit           |"
	echo "          ==============================================="
	echo
else
	echo
	echo "          ==============================================="
	echo "          |             NO BUILDROOT FOUND              |"
	echo "          ==============================================="
	echo
	exit 1
fi


# Editor (tools)
scons -j1 tools=yes target=release_debug debug_symbols=no platform=x11 bits=32 2>&1 | tee ./logs/scons_x11_32_tools_build.txt;

# Template(s)
scons -j1 tools=no target=release_debug debug_symbols=no platform=x11 bits=32 2>&1 | tee ./logs/scons_x11_32_debug_build.txt;

# Removing debug symbols
strip ./bin/godot.x11.*
