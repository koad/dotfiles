#!/usr/bin/env bash
# install_cairo_dock.sh
# Clone, build and install Cairo-Dock core and plug-ins (excluding Impulse) from source.

set -euo pipefail

CAIRO_DIR="${HOME}/.cairo"

# Install build dependencies
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

# Clone repositories if missing
mkdir -p "${CAIRO_DIR}"
cd "${CAIRO_DIR}"
if [ ! -d cairo-dock-core ]; then
  git clone https://github.com/Cairo-Dock/cairo-dock-core.git
fi
if [ ! -d cairo-dock-plug-ins ]; then
  git clone https://github.com/Cairo-Dock/cairo-dock-plug-ins.git
fi

# Build and install core
cd cairo-dock-core
rm -rf build
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make -j"$(nproc)"
sudo make install

# Verify gldi pkg-config
pkg-config --modversion gldi

# Build and install plug-ins (Impulse disabled)
cd "${CAIRO_DIR}/cairo-dock-plug-ins"
rm -rf build
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -Denable-impulse=no
make -j"$(nproc)"
sudo make install

echo "Cairo-Dock installation complete. Run 'cairo-dock --version' to verify."
