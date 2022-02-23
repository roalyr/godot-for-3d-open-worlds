#!/bin/sh

# For Android templates
export ANDROID_SDK_ROOT="$HOME/Android/Sdk";

# For incremental
export SCONS_CACHE="./scons_cache";
export SCONS_CACHE_LIMIT=10000;

mkdir -p $SCONS_CACHE

# Editor
scons -j2 platform=x11;
# scons -j2 target=release_debug platform=x11;

# Template(s)
# Linux, removing debug symbols
scons -j1 platform=x11 tools=no target=release bits=64;
strip ./bin/godot.x11.opt.64

# Android
scons -j1 platform=android target=release_debug android_arch=armv7;
scons -j1 platform=android target=release_debug android_arch=arm64v8;
cd platform/android/java;
./gradlew generateGodotTemplates;



