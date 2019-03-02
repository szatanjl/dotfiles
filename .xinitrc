#!/bin/sh -eu

# Run desktop environment.  Executed by startx.
# See startx(1) and xinit(1) for details.

dwm-status &
dwm-wallpaper &
xcompmgr &
exec dwm
