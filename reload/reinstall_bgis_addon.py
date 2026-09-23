import bpy, pathlib, addon_utils, shutil, json

EPSG_CODE = 3358  # North Carolina NAD(HARN)

# Install zip
bpy.ops.preferences.addon_install(overwrite=True, filepath='/tmp/tangible-landscape-install/blender_gis.zip')

# Locate installed directory and rename to 'BlenderGIS'
addons_dir = pathlib.Path(bpy.utils.user_resource('SCRIPTS', path='addons'))
gis_dir = next(addons_dir.glob('BlenderGIS*'))
target_dir = addons_dir / 'BlenderGIS'

if gis_dir != target_dir:
	if target_dir.exists():
		shutil.rmtree(target_dir)
	shutil.move(str(gis_dir), str(target_dir))

# Refresh modules and enable standard 'BlenderGIS'
addon_utils.modules_refresh()
bpy.ops.preferences.addon_enable(module='BlenderGIS')
bpy.ops.wm.save_userpref()

# Adding a new default and keeping the previous CRS'
prefs = bpy.context.preferences.addons['BlenderGIS'].preferences
data = json.loads(prefs.predefCrsJson)

# Append new preset tuple: (crs, name, description)
new_crs = (
	f'EPSG:{EPSG_CODE}', 
	'Tangible Landscape Default', 
	f'Tangible Landscape Default - EPSG:{EPSG_CODE}'
)

# Avoid duplicates
if not any(item[0] == new_crs[0] for item in data):
    data.append(new_crs)

# Save updated JSON list to user preferences
prefs.predefCrsJson = json.dumps(data)

# Selecting the new CRS
prefs.predefCrs = f'EPSG:{EPSG_CODE}'
bpy.ops.wm.save_userpref()
