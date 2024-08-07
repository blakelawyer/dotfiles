#!/bin/bash

current_date=$(date +%Y-%m-%d)

start_date=$(date -d "last monday" +%Y-%m-%d)
start_month=$(date -d "$start_date" +%-m)
start_day=$(date -d "$start_date" +%-d)

end_date=$(date -d "next sunday" +%Y-%m-%d)
end_month=$(date -d "$end_date" +%-m)
end_day=$(date -d "$end_date" +%-d)

file_path=~/notes/periodic/1-weekly/$start_month-$start_day-$end_month-$end_day.md

template_path=~/notes/templates/weekly.md

if [ -e "$file_path" ]; then
    echo "$file_path"
else
    mkdir -p $(dirname "$file_path")

    cp "$template_path" "$file_path"

    formatted_date="# Week of $start_month/$start_day to $end_month/$end_day"

    sed -i "1s/.*/$formatted_date/" "$file_path"

    echo "$file_path"
fi

