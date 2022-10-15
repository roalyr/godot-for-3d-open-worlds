#!/bin/sh

# For Android templates
export ANDROID_SDK_ROOT="$HOME/Android/Sdk";

# For incremental
export SCONS_CACHE="./scons_cache/scons_cache_android";
mkdir -p $SCONS_CACHE


# Android editor
scons -j1 tools=yes platform=android target=release_debug debug_symbols=no android_arch=armv7 2>&1 | tee ./logs/scons_android_armv7_tools_build.txt;
scons -j1 tools=yes platform=android target=release_debug debug_symbols=no android_arch=arm64v8 2>&1 | tee ./logs/scons_android_arm64v8_tools_build.txt;

# Android templates
scons -j1 tools=no platform=android target=release_debug debug_symbols=no android_arch=armv7 2>&1 | tee ./logs/scons_android_armv7_debug_build.txt;
scons -j1 tools=no platform=android target=release_debug debug_symbols=no android_arch=arm64v8 2>&1 | tee ./logs/scons_android_arm64v8_debug_build.txt;

cd platform/android/java;
./gradlew generateGodotTemplates;
./gradlew generateGodotEditor;
