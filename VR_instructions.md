**Virtual Reality Set-Up**
![Image of Virutal Reality in use](vr_use.jpg "Virtual Reality in Use")

**Prerequisites:**
* Oculus Meta Quest 3 (Headset)
* Computer Running Ubuntu (PC)
* Phone for Setup Purposes

**Installation**
1. Blender Installation (PC)
    1. Install Blender 5.0.1 or similar
    2. Install and configure the Tangible Landscape Blender Addon
    3. Enable the "VR Scene Inspection" Blender Addon 
2. Steam Installation (PC)
    1. Install Steam on your PC ```sudo apt install update && sudo apt install steam```
    2. From Steam, install Steam VR
3. Air Light VR Installation (PC)
    1. Install the ALVR Linux Launcher from ```https://github.com/alvr-org/ALVR/releases/```, look for ```alvr_launcher_linux.tar.gz```
    2. Unzip and run ```ALVR Launcher.exe```
    3. Press "Add Version" and select the latest version
    4. Remember this version for the headset and accept the default install parameters
6. Air Light VR Streamer Installation (Headset)
    1. To setup the headset initially, you'll need a Meta Account. The headset guides you through this process at the initial usage.   
    2. On the headset, go the app store and install the same ALVR version as the PC

**Running Virtual Reality**
1. General Setup (Headset, PC)
    1. Ensure that both the Headset and PC are connected to the same local WiFi network
    2. Enable bluetooth for both devices
2. Tangible Landscape Setup (PC)
    1. Run ```g.gui.tangible``` in your GRASS location
    2. Run Blender with the Tangible Landscape addon started
3. Steam Setup (PC)
    1. Run Steam
    2. From Steam, launch Steam VR
3. ALVR Launcher Setup (PC)
    1. Run ```ALVR Launcher.exe```
    2. Click "Launch" next to your installed version
    3. Ensure that ALVR sees the instance of Steam VR that's currently running
5. ALVR Streamer Setup (Headset, PC)
    1. Ensure that no apps are running on the headset
    2. Run ALVR, you should see a hostname and IP address for the headset
    3. In ALVR on your PC, select "Add Device Manually" next to "Trusted Wireless Devices"
    4. Input the hostname and IP Address shown in the headset
6. Starting Activity (PC)
    1. 2-Way streaming should be started at this point, and you can confirm by looking at the headset pose on SteamVR
    2. In Blender, in the VR Addon, select "Start VR Session" to begin streaming your Blender model to the Headset

**Common Issues**

`ERROR * profile does not contain encoding entrypoint. Your gpu may not suport encoding with this. `

This error happens on systems with both an integrated GPU and an external GPU. SteamVR tries to use the integrated GPU, which often doesn't support the specific image encoding methods that ALVR uses. To fix this,
1. Ensure the codec in ALVR settings is set to H.264
2. Launch Ubuntu on Wayland (This may not be necessary, but doesn't hurt in my testing) (Requires restart)
3. Open Steam -> SteamVR -> Manage (Gear Icon) -> Properties -> General -> Launch Options and enter this (replace the path with your SteamVR installation)
```
__GLX_VENDOR_LIBRARY_NAME=nvidia __NV_PRIME_RENDER_OFFLOAD=1 VK_DRIVER_FILES=/usr/share/vulkan/icd.d/nvidia_icd.json <absolute_path_to>/SteamVR/bin/vrmonitor.sh %command%
```
4. Launch blender with the following options, (you may have to change "blender" if it's not in your PATH)
```
__GLX_VENDOR_LIBRARY_NAME=nvidia __NV_PRIME_RENDER_OFFLOAD=1 VK_DRIVER_FILES=/usr/share/vulkan/icd.d/nvidia_icd.json blender
```