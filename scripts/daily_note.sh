#!/bin/bash

current_month=$(date +%-m)
current_day=$(date +%-d)
current_year=$(date +%Y)
day_of_week=$(date +%A)
full_month=$(date +%B)

file_path=~/notes/periodic/0-daily/$current_month/$current_day.md

template_path=~/notes/templates/daily.md

if [ -e "$file_path" ]; then
    echo "$file_path"
else
    mkdir -p $(dirname "$file_path")

    cp "$template_path" "$file_path"

    formatted_date="# $day_of_week, $full_month $current_day, $current_year"

    sed -i "1s/.*/$formatted_date/" "$file_path"

    echo "$file_path"
fi

