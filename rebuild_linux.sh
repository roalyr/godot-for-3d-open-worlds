#!/bin/sh

# For incremental
export SCONS_CACHE="./scons_cache_x11";
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

# Editor (tools)
scons -j1 tools=yes target=release_debug debug_symbols=no platform=x11 bits=64;

# Template(s)
scons -j1 tools=no target=release_debug debug_symbols=no platform=x11 bits=64;

# Removing debug symbols
strip ./bin/godot.x11.*
