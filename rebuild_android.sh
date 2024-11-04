#!/bin/sh

# For Android templates
export ANDROID_SDK_ROOT="$HOME/Android/Sdk";

# For incremental
export SCONS_CACHE="./scons_cache/scons_cache_android";
mkdir -p $SCONS_CACHE
mkdir -p "./logs"


	echo
	echo "          ==============================================="
	echo "          |        BUILDING ANDROID ARM7, ARM64v8       |"
	echo "          ==============================================="
	echo

# Android editor
scons -j2 tools=yes platform=android target=release_debug debug_symbols=no android_arch=armv7 2>&1 | tee ./logs/scons_android_armv7_tools_build.txt;
scons -j2 tools=yes platform=android target=release_debug debug_symbols=no android_arch=arm64v8 2>&1 | tee ./logs/scons_android_arm64v8_tools_build.txt;

# Android templates
scons -j2 tools=no platform=android target=release_debug debug_symbols=no android_arch=armv7 2>&1 | tee ./logs/scons_android_armv7_debug_build.txt;
scons -j2 tools=no platform=android target=release_debug debug_symbols=no android_arch=arm64v8 2>&1 | tee ./logs/scons_android_arm64v8_debug_build.txt;

cd platform/android/java;
./gradlew generateGodotTemplates;
./gradlew generateGodotEditor;

	echo
	echo "          ==============================================="
	echo "          |     DONE BUILDING ANDROID ARM7, ARM64v8     |"
	echo "          ==============================================="
	echo
