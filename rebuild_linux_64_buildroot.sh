#!/bin/sh

# For incremental
export SCONS_CACHE="./scons_cache/godot_4_scons_cache_x11_64";
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
scons -j2 platform=linuxbsd precision=double 2>&1 | tee ./logs/godot_4_scons_linuxbsd_86_64_tools_build.txt;

# Template(s)
scons -j2 platform=linuxbsd precision=double target=template_debug arch=x86_64 2>&1 | tee ./logs/godot_4_scons_linuxbsd_86_64_template_build.txt;
#scons -j2 platform=linuxbsd precision=double target=template_release arch=x86_64 2>&1 | tee ./logs/godot_4_scons_linuxbsd_86_64_template_release_build.txt;


# Removing debug symbols
#strip ./bin/godot.linuxbsd.editor.double.x86_64
#strip ./bin/godot.linuxbsd.template_debug.double.x86_64
#strip ./bin/godot.linuxbsd.template_release.double.x86_64

	echo
	echo "          ==============================================="
	echo "          |      DONE BUILDING LINUX x86-64 64 bit      |"
	echo "          ==============================================="
	echo
