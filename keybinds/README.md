# keybinds

Tiling-style window placement on GNOME using `wmctrl` and custom keybindings.

> **Requires X11.** `wmctrl` does not work under Wayland. In GNOME, make sure to select "GNOME on Xorg" at the login screen.

## Mindset

GNOME is a floating window manager. These keybindings make it feel like a tiling WM by snapping the active window to named positions with a single keypress.

The key layout mirrors the physical position on the desktop:

```
Super + Q  W  E  R      ← top row positions
         A  S  D        ← middle row positions
         Z  X           ← parking / lower zone
```

5-7 placements is enough. The goal is muscle memory, not exhaustive coverage.

## Structure

```
install.sh          entry point — run this to apply keybindings
shapes/             one file per monitor layout
```

## How it works

1. `install.sh` reads the connected monitors via `xrandr`, parses their resolutions, and builds a layout key (e.g. `1920x1200+2560x1440`) — monitors sorted left to right by X offset.
2. Common keybindings that apply regardless of monitor layout are registered directly in `install.sh`.
3. If a matching file exists in `shapes/`, it is executed — registering the layout-specific placements for that exact monitor configuration.

## Adding a new layout

Name the file after the monitor resolutions in left-to-right order, joined by `+`:

```
shapes/1920x1080.sh
shapes/1920x1200.sh
shapes/2560x1440.sh
shapes/1920x1200+2560x1440.sh
shapes/1920x1200+2560x1440+1920x1200.sh
```

Use `../scripts/add-keybinding.sh` to register each placement:

```bash
../scripts/add-keybinding.sh "name" "wmctrl -r :ACTIVE: -e 0,x,y,w,h" "<Super>q"
```

## Helpers

```bash
./install.sh                     # detect layout and apply all keybindings
../scripts/clear.sh              # wipe all custom keybindings
../scripts/list.sh               # show currently registered keybindings
../scripts/detect-resolution.sh  # show monitor info
```
