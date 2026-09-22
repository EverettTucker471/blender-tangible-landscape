#!/bin/bash

# The coupling directory, we assume the development repo is inside
ADDON_NAME="Blender for Tangible Landscape"
COUPLING_DIR="/workspace/coupling"
INSTALL_PATH="/tmp/tangible-landscape-install"
WATCH_DIR=$COUPLING_DIR/Watch
REPO_NAME="blender-tangible-landscape"
ZIP_PATH="$COUPLING_DIR/zip/blender_tangible_landscape.zip"

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
zip -r "$ZIP_PATH" "$INSTALL_PATH/$REPO_NAME" -x "*/.*" "*/__pycache__/*" "*.pyc" "reload/*" "scratch/*" "Watch/*" "zip/*"

# Installing the addon and configuring
blender --background --python "$INSTALL_PATH/$REPO_NAME/reload/reinstall_addon.py" -- --addon_zip_path "$ZIP_PATH" --coupling_path "$WATCH_DIR" --addon_name "$REPO_NAME"

# Installing BlenderGIS
cd $INSTALL_PATH
curl -L -o blender_gis.zip https://github.com/domlysz/BlenderGIS/archive/refs/tags/2215.zip
blender --background --python-expr "import bpy; bpy.ops.preferences.addon_install(overwrite=True, filepath='/tmp/tangible-landscape-install/blender_gis.zip'); bpy.ops.preferences.addon_enable(module='BlenderGIS'); bpy.ops.wm.save_userpref()"