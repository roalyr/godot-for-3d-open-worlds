#!/bin/sh

# For incremental
#export SCONS_CACHE="./scons_cache/godot_4_scons_cache_linux_arm32";
#mkdir -p $SCONS_CACHE
mkdir -p "./logs"

# Reference buildroot and see if scons is used from there
BUILDROOT_PATH="$HOME/Buildroot/arm-godot-linux-gnueabihf_sdk-buildroot/bin"
PATH=$BUILDROOT_PATH:$PATH 
WHICHSCONS=$(which scons)

if [ "${BUILDROOT_PATH}/scons" = $WHICHSCONS ]
then
	echo
	echo "          ==============================================="
	echo "          |       USING BUILDROOT LINUX ARM32 bit       |"
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
scons -j2 platform=linuxbsd precision=double arch=arm32 2>&1 | tee ./logs/godot_4_scons_linuxbsd_arm32_tools_build.txt;

# Template(s)
scons -j2 platform=linuxbsd precision=double target=template_debug arch=arm32 2>&1 | tee ./logs/godot_4_scons_linuxbsd_arm32_template_build.txt;
#scons -j2 platform=linuxbsd precision=double target=template_release arch=arm32 2>&1 | tee ./logs/godot_4_scons_linuxbsd_arm32_template_release_build.txt;

	echo
	echo "          ==============================================="
	echo "          |       DONE BUILDING LINUX ARM32 bit         |"
	echo "          ==============================================="
	echo
