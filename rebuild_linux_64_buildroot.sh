#!/bin/sh

# For incremental
export SCONS_CACHE="./scons_cache/scons_cache_x11_64";
mkdir -p $SCONS_CACHE

# Reference buildroot and see if scons is used from there
BUILDROOT_PATH="/home/roalyr/Buildroot/x86_64-godot-linux-gnu_sdk-buildroot/bin"
PATH=$BUILDROOT_PATH:$PATH 
WHICHSCONS=$(which scons)

if [ "${BUILDROOT_PATH}/scons" = $WHICHSCONS ]
then
	echo
	echo "          ==============================================="
	echo "          |     USING BUILDROOT LINUX x86-64 64 bit     |"
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
scons -j1 tools=yes target=release_debug debug_symbols=no platform=x11 bits=64 2>&1 | tee ./logs/scons_x11_86_64_tools_build.txt;

# Template(s)
scons -j1 tools=no target=release_debug debug_symbols=no platform=x11 bits=64 2>&1 | tee ./logs/scons_x11_86_64_debug_build.txt;

# Rename binaries
mv ./bin/godot.x11.opt.tools.64 ./bin/godot.x11.opt.tools.x86_64
mv ./bin/godot.x11.opt.debug.64 ./bin/godot.x11.opt.debug.x86_64

# Removing debug symbols
strip ./bin/godot.x11.opt.tools.x86_64
strip ./bin/godot.x11.opt.debug.x86_64

	echo
	echo "          ==============================================="
	echo "          |      DONE BUILDING LINUX x86-64 64 bit      |"
	echo "          ==============================================="
	echo