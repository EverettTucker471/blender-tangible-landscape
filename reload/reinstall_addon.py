"""
Reinstalls the Blender Tangible Landscape addon and configures the Coupling path
Author(s): Everett Tucker
Usage:
    blender --background --python reload_addon.py -- \
        --addon_zip_path /path/to/blender-tangible-landscape-master.zip \
        --coupling_path /path/to/coupling/directory
"""

import sys
import bpy
import argparse


def main():
    # Removing the breaker argument from between the blender and python calls
    argv = sys.argv
    if "--" in argv:
        argv = argv[argv.index("--") + 1:]
    else:
        argv = []

    # Getting command-line arguments from the reload_addon script
    parser = argparse.ArgumentParser(description='Reinstall Blender Tangible Landscape with the given coupling path')
    parser.add_argument('--addon_zip_path', help="The absolute path to your zipped addon (blender-tangible-landscape-master.zip)", required=True)
    parser.add_argument('--coupling_path', help='The absolute path to your Tangible Landscape coupling directory', required=True)
    parser.add_argument('--addon_name', help="The name of the add-on, should be the same as the repo name", required=True)
    args = parser.parse_args(argv)

    # Install the fresh addon from the zip path
    bpy.ops.preferences.addon_install(filepath=args.addon_zip_path, enable_on_install=True)

    # Configure the addon with the tl_coupling path
    prefs = bpy.context.preferences.addons[args.addon_name].preferences
    prefs.folder = args.coupling_path
    bpy.ops.wm.save_userpref()
    print(f"{args.addon_name} Successfully Reloaded")


if __name__ == '__main__':
    main()
