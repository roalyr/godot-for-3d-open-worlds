#!/bin/sh

# For Android templates
export ANDROID_SDK_ROOT="$HOME/Android/Sdk";

# For incremental
export SCONS_CACHE="./scons_cache/godot_4_scons_cache_android";
mkdir -p $SCONS_CACHE

	echo
	echo "          ==============================================="
	echo "          |        BUILDING ANDROID ARM7, ARM64v8       |"
	echo "          ==============================================="
	echo

# Android editor
scons -j2 platform=android precision=double production=yes target=editor arch=armv7 2>&1 | tee ./logs/godot_4_scons_android_armv7_tools_build.txt;
scons -j2 platform=android precision=double production=yes target=editor arch=arm64v8 2>&1 | tee ./logs/godot_4_scons_android_arm64v8_tools_build.txt;

# Android templates
scons -j2 platform=android precision=double target=template_debug arch=armv7 2>&1 | tee ./logs/godot_4_scons_android_armv7_template_build.txt;
scons -j2 platform=android precision=double target=template_debug arch=arm64v8 2>&1 | tee ./logs/godot_4_scons_android_arm64v8_template_build.txt;

cd platform/android/java;
./gradlew generateGodotTemplates;
./gradlew generateGodotEditor;

	echo
	echo "          ==============================================="
	echo "          |     DONE BUILDING ANDROID ARM7, ARM64v8     |"
	echo "          ==============================================="
	echo
