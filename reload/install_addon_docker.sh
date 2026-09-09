#!/bin/bash

# The coupling directory, we assume the development repo is inside
ADDON_NAME="Blender for Tangible Landscape"
COUPLING_DIR="tmp/tangible-landscape-install/coupling"
WATCH_DIR=$COUPLING_DIR/Watch
REPO_NAME="blender-tangible-landscape"
ZIP_PATH="$COUPLING_DIR/zip/blender-tangible-landscape-master.zip"

# quitting current blender window - make sure to save first
pkill blender

# waiting for blender to die
while pgrep -x "blender" > /dev/null; do
    sleep 1
done

# Path to zip the file to, should be outside
mkdir -p $COUPLING_DIR/zip
mkdir -p $WATCH_DIR
rm -f $COUPLING_DIR/zip/*.zip

cd $COUPLING_DIR
zip -r "$ZIP_PATH" $REPO_NAME -x "*/.*" "*/__pycache__/*" "*.pyc" "reload/*" "scratch/*" "Watch/*" "zip/*"

# Installing the addon and configuring
blender --background --python "./$REPO_NAME/reload/reinstall_addon.py" -- --addon_zip_path "$ZIP_PATH" --coupling_path "$WATCH_DIR" --addon_name "$REPO_NAME"
