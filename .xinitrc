#!/bin/sh -eu

# Run desktop environment.  Executed by startx.
# See startx(1) and xinit(1) for details.

# Configure keyboard and remap Caps Lock to Escape.
# See setxkbmap(1) for details.
setxkbmap -model pc104 -layout pl -option caps:escape

# Configure touchpad.  See xinput(1) and libinput(4) for details.
dev="$(xinput list --name-only | grep -i touchpad)"
## Configure buttons
xinput set-prop "$dev" 'libinput Click Method Enabled'            1 0
xinput set-prop "$dev" 'libinput Middle Emulation Enabled'        0
xinput set-prop "$dev" 'libinput Left Handed Enabled'             0
## Configure tapping
xinput set-prop "$dev" 'libinput Tapping Enabled'                 1
xinput set-prop "$dev" 'libinput Tapping Drag Enabled'            1
xinput set-prop "$dev" 'libinput Tapping Drag Lock Enabled'       0
xinput set-prop "$dev" 'libinput Tapping Button Mapping Enabled'  1 0
## Configure scrolling
xinput set-prop "$dev" 'libinput Scroll Method Enabled'           1 0 0
xinput set-prop "$dev" 'libinput Horizontal Scroll Enabled'       1
xinput set-prop "$dev" 'libinput Natural Scrolling Enabled'       0
## Configure speed
xinput set-prop "$dev" 'libinput Accel Profile Enabled'           0 1
xinput set-prop "$dev" 'libinput Accel Speed'                     0.5
## Disable while typing
xinput set-prop "$dev" 'libinput Disable While Typing Enabled'    1

redshift-gtk &
nm-applet &
blueman-applet &

dwm-status &
dwm-wallpaper &
xcompmgr &
exec dwm
