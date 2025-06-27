#!/bin/sh

# For incremental
#export SCONS_CACHE="./scons_cache/godot_4_scons_cache_linux_x86_32";
#mkdir -p $SCONS_CACHE
mkdir -p "./logs"

# Reference buildroot and see if scons is used from there
BUILDROOT_PATH="$HOME/Buildroot/i686-godot-linux-gnu_sdk-buildroot/bin"
PATH=$BUILDROOT_PATH:$PATH 
WHICHSCONS=$(which scons)

if [ "${BUILDROOT_PATH}/scons" = $WHICHSCONS ]
then
	echo
	echo "          ==============================================="
	echo "          |       USING BUILDROOT LINUX x86-32 bit      |"
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
scons -j2 platform=linuxbsd precision=double arch=x86_32 2>&1 | tee ./logs/godot_4_scons_linuxbsd_86_32_tools_build.txt;

# Template(s)
scons -j2 platform=linuxbsd precision=double target=template_debug arch=x86_32 2>&1 | tee ./logs/godot_4_scons_linuxbsd_86_32_template_build.txt;
#scons -j2 platform=linuxbsd precision=double target=template_release arch=x86_32 2>&1 | tee ./logs/godot_4_scons_linuxbsd_86_32_template_release_build.txt;


	echo
	echo "          ==============================================="
	echo "          |       DONE BUILDING LINUX x86-32 bit        |"
	echo "          ==============================================="
	echo
