#!/bin/sh

# For incremental
export SCONS_CACHE="./scons_cache/scons_cache_x11_armv8";
mkdir -p $SCONS_CACHE

# Reference buildroot and see if scons is used from there
BUILDROOT_PATH="/home/roalyr/Buildroot/arm-godot-linux-gnueabihf_sdk-buildroot/bin"
PATH=$BUILDROOT_PATH:$PATH 
WHICHSCONS=$(which scons)

if [ "${BUILDROOT_PATH}/scons" = $WHICHSCONS ]
then
	echo
	echo "          ==============================================="
	echo "          |      USING BUILDROOT LINUX ARMv8 64 bit     |"
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
scons -j1 tools=yes target=release_debug debug_symbols=no platform=x11 CCFLAGS="-mtune=cortex-a72 -mcpu=cortex-a72 -mfloat-abi=hard -mlittle-endian -munaligned-access -mfpu=neon-fp-armv8" module_denoise_enabled=no module_raycast_enabled=no module_webm_enabled=no module_theora_enabled=no 2>&1 | tee ./logs/scons_x11_armv8_tools_build.txt;

# Template(s)
scons -j1 tools=no target=release_debug debug_symbols=no platform=x11 CCFLAGS="-mtune=cortex-a72 -mcpu=cortex-a72 -mfloat-abi=hard -mlittle-endian -munaligned-access -mfpu=neon-fp-armv8" module_denoise_enabled=no module_raycast_enabled=no module_webm_enabled=no module_theora_enabled=no 2>&1 | tee ./logs/scons_x11_armv8_debug_build.txt;

# Rename binaries (it writes them as "64" at the moment).
mv ./bin/godot.x11.opt.tools.64 ./bin/godot.x11.opt.tools.armv8
mv ./bin/godot.x11.opt.debug.64 ./bin/godot.x11.opt.debug.armv8

# Removing debug symbols
strip ./bin/godot.x11.opt.tools.armv8
strip ./bin/godot.x11.opt.debug.armv8

	echo
	echo "          ==============================================="
	echo "          |      DONE BUILDING LINUX ARMv8 64 bit       |"
	echo "          ==============================================="
	echo