#!/bin/sh

# For Android templates
export ANDROID_SDK_ROOT="$HOME/Android/Sdk";

# For incremental
export SCONS_CACHE="./scons_cache_android";
mkdir -p $SCONS_CACHE

# Target controls optimization and debug flags. Each mode means:
# debug: Build with C++ debugging symbols, runtime checks 
#		(performs checks and reports error) and none to little optimization.
# release_debug: Build without C++ debugging symbols and optimization, 
#		but keep the runtime checks (performs checks and reports errors). 
#		Official editor binaries use this configuration.
# release: Build without symbols, with optimization and with little to no runtime checks. 
#		This target can't be used together with tools=yes, as the editor requires some debug 
# 		functionality and run-time checks to run.

# Android editor
scons -j1 tools=yes platform=android target=release_debug debug_symbols=no android_arch=armv7 2>&1 | tee ./logs/scons_android_armv7_tools_build.log;
scons -j1 tools=yes platform=android target=release_debug debug_symbols=no android_arch=arm64v8 2>&1 | tee ./logs/scons_android_arm64v8_tools_build.log;

# Android templates
scons -j1 tools=no platform=android target=release_debug debug_symbols=no android_arch=armv7 2>&1 | tee ./logs/scons_android_armv7_debug_build.log;
scons -j1 tools=no platform=android target=release_debug debug_symbols=no android_arch=arm64v8 2>&1 | tee ./logs/scons_android_arm64v8_debug_build.log;

cd platform/android/java;
./gradlew generateGodotTemplates;
./gradlew generateGodotEditor;
