#!/bin/bash

# xrandr --output LVDS1 --mode 1366x768 --pos 1366x0 --rotate normal --output DP1 --off --output HDMI1 --off --output VGA1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output VIRTUAL1 --off

$(/home/demian/test/t.sh)

nitrogen --restore

picom &
