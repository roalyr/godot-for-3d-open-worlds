#!/bin/sh

# For incremental
export SCONS_CACHE="./scons_cache/scons_cache_x11_arm32";
mkdir -p $SCONS_CACHE
mkdir -p "./logs"

# Reference buildroot and see if scons is used from there
BUILDROOT_PATH="/home/roalyr/Buildroot/arm-godot-linux-gnueabihf_sdk-buildroot/bin"
PATH=$BUILDROOT_PATH:$PATH 
WHICHSCONS=$(which scons)

if [ "${BUILDROOT_PATH}/scons" = $WHICHSCONS ]
then
	echo
	echo "          ==============================================="
	echo "          |       USING BUILDROOT LINUX ARM  32 bit     |"
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
scons -j2 tools=yes target=release_debug platform=x11 debug_symbols=no arch=arm32 2>&1 | tee ./logs/scons_x11_arm32_tools_build.txt;

# Template(s)
scons -j2 tools=no target=release_debug platform=x11 debug_symbols=no arch=arm32 2>&1 | tee ./logs/scons_x11_arm32_debug_build.txt;



	echo
	echo "          ==============================================="
	echo "          |       DONE BUILDING LINUX ARM 32 bit        |"
	echo "          ==============================================="
	echo
