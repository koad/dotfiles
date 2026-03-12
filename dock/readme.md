 # Building Cairo-Dock from source

 This directory contains a helper script and documentation for building Cairo-Dock
 core (3.6.98) and official plug-ins (excluding the Impulse plug-in) from source on
 Debian 12 (Bookworm).

 ## Prerequisites

 Install required packages for building Cairo-Dock:

 ```bash
 sudo apt update
 sudo apt install -y \
   pkg-config build-essential cmake gettext \
   libglib2.0-dev libcairo2-dev librsvg2-dev \
   libdbus-1-dev libdbus-glib-1-dev libxml2-dev \
   libcurl4-gnutls-dev libx11-dev libxext-dev \
   libxrandr-dev libxcomposite-dev libxrender-dev \
   libegl1-mesa-dev libgbm-dev libgl1-mesa-dev \
   libglu1-mesa-dev libgtk-3-dev libpango1.0-dev \
   libcrypt-dev libwayland-dev libwayland-egl-backend-dev \
   libasound2-dev libpulse-dev
 ```

 ## Usage

 Run the helper script to clone, build, and install Cairo-Dock core and plug-ins:

 ```bash
 cd ~/.cairo
 chmod +x install_cairo_dock.sh
 ./install_cairo_dock.sh
 ```

 The script will:
 - Clone the `cairo-dock-core` and `cairo-dock-plug-ins` repositories under `~/.cairo`
 - Configure and build Cairo-Dock core in `~/.cairo/cairo-dock-core/build`
 - Install core libraries and pkg-config files (`gldi.pc`)
 - Configure and build plug-ins in `~/.cairo/cairo-dock-plug-ins/build` (Impulse disabled)
 - Install plug-in libraries and desktop integration files

 After installation, verify the version:

 ```bash
 cairo-dock --version   # should report 3.6.98
 ```

 ## Customization

 - Enable the Impulse plug-in by editing `install_cairo_dock.sh` and removing
   `-Denable-impulse=no` from the plug-in build step.
 - Enable desktop-manager integration in core by adding
   `-Denable-desktop-manager=True` to the core build step.

 ## License

 This script and documentation are provided as-is under the MIT License.
