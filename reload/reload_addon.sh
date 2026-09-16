#!/bin/bash

# The coupling directory, we assume the development repo is inside
# ADDON_NAME="Blender for Tangible Landscape"
ADDON_NAME="blender-tangible-landscape-master"
COUPLING_DIR="/home/everetttucker471/IGroup/TL_coupling"
REPO_NAME="blender-tangible-landscape"

# quitting current blender window - make sure to save first
pkill blender

# waiting for blender to die
while pgrep -x "blender" > /dev/null; do
    sleep 1
done

# Path to zip the file to, should be outside
mkdir -p $COUPLING_DIR/zip
rm $COUPLING_DIR/zip/*.zip
ZIP_PATH="$COUPLING_DIR/zip/blender-tangible-landscape-master.zip"

cd $COUPLING_DIR
zip -r "$ZIP_PATH" $REPO_NAME -x "*/.*" "*/__pycache__/*" "*.pyc" "reload/*" "scratch/*" "Watch/*" "zip/*"

# Installing the addon and configuring
blender --background --python "$COUPLING_DIR/$REPO_NAME/reload/reinstall_addon.py" -- --addon_zip_path "$ZIP_PATH" --coupling_path "$COUPLING_DIR" --addon_name "$REPO_NAME"

# Reopening blender 5.0, assuming it's sourced correctly
blender