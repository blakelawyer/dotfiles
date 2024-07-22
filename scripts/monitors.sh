#!/bin/bash

xrandr --output LVDS1 --off
xrandr --output DP2 --primary --mode 1920x1080 --output DP3 --mode 1920x1080 --right-of DP2
