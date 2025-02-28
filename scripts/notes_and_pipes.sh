#!/bin/bash

if [[ "$(autorandr --current)" == "laptop" ]]; then

    # pipes.sh background
    i3-msg "workspace 2; exec alacritty -e zsh -ic 'pipes.sh -t 3 -r 5000 -R'"

    # Open notes as floating terminal foreground
    i3-msg "workspace 3; exec alacritty -e zsh -ic 'notes'"
    sleep 1
    i3-msg "floating enable, resize set 80 ppt 60 ppt, move position center"

    # Move workspaces together 
    i3-msg "workspace 2; move container to workspace 1"
    i3-msg "workspace 3; move container to workspace 1"

    # Focus on notes
    i3-msg "workspace 1;"
else
    alacritty -e zsh -ic 'notes'
fi
