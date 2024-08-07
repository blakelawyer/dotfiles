#!/bin/bash

mkdir -p ~/notes/inbox

timestamp=$(date +%s)

file_path=~/notes/inbox/"$timestamp".md

nvim "$file_path"

