#!/bin/sh

# Create temporary directory
TEMP_DIR=$(mktemp -d)

# Copy executable file to temporary directory
cp ./.build/release/MusicTimer $TEMP_DIR

# Create disk image
hdiutil create -srcfolder $TEMP_DIR -format UDZO -volname "MusicTimer" -ov "MusicTimer.dmg"

# Cleanup
rm -rf $TEMP_DIR
