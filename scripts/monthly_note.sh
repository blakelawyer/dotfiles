#!/bin/bash

current_year=$(date +%Y)
current_month=$(date +%B | tr '[:upper:]' '[:lower:]')  

file_path=~/notes/periodic/2-monthly/$current_month.md

template_path=~/notes/templates/monthly.md

if [ -e "$file_path" ]; then
    echo "$file_path"
else
    mkdir -p $(dirname "$file_path")

    cp "$template_path" "$file_path"

    formatted_date="# $current_month $current_year"

    sed -i "1s/.*/$formatted_date/" "$file_path"

    echo "$file_path"
fi

