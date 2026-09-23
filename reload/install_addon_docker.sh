#!/bin/bash
set -e

ADDON_NAME="blender_tangible_landscape"
COUPLING_DIR="/workspace/coupling"
INSTALL_PATH="/tmp/tangible-landscape-install"
WATCH_DIR="$COUPLING_DIR/Watch"
REPO_NAME="blender-tangible-landscape"
ZIP_PATH="$COUPLING_DIR/zip/$ADDON_NAME.zip"

# Quitting current blender window - make sure to save first
pkill blender || true

# Waiting for blender to die
while pgrep -x "blender" > /dev/null; do
    sleep 1
done

mkdir -p "$COUPLING_DIR/zip"
mkdir -p "$WATCH_DIR"
rm -f "$COUPLING_DIR/zip"/*.zip

# Package Tangible Landscape with matching module name
cd "$INSTALL_PATH"
cp -r "$REPO_NAME" "$ADDON_NAME"
zip -r "$ZIP_PATH" "$ADDON_NAME" -x "*/.*" "*/__pycache__/*" "*.pyc" "reload/*" "scratch/*" "Watch/*" "zip/*"
rm -rf "$ADDON_NAME"

# Install Tangible Landscape
blender --background --python "$INSTALL_PATH/$REPO_NAME/reload/reinstall_tl_addon.py" -- \
    --addon_zip_path "$ZIP_PATH" \
    --coupling_path "$WATCH_DIR" \
    --addon_name "$ADDON_NAME"

# Download BlenderGIS
cd "$INSTALL_PATH"
curl -L -o blender_gis.zip https://github.com/domlysz/BlenderGIS/archive/refs/tags/2215.zip

# Install BlenderGIS
blender --background --python "$INSTALL_PATH/$REPO_NAME/reload/reinstall_bgis_addon.py"