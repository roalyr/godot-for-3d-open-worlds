#!/bin/sh

# For Android templates
export ANDROID_SDK_ROOT="/home/roalyr/Android/Sdk";

# For incremental
export SCONS_CACHE="/home/roalyr/Software archive/applications/Godot 3/Source/godot-3.4/scons_cache";
export SCONS_CACHE_LIMIT=10000;


# Editor
scons -j8 platform=x11;

# Template(s)
scons -j8 platform=x11 tools=no target=release bits=64;
scons -j8 platform=android target=release_debug android_arch=armv7;
scons -j8 platform=android target=release_debug android_arch=arm64v8;
cd platform/android/java;
./gradlew generateGodotTemplates;

