#!/bin/bash

find "$2" -maxdepth 1 -type f -name "*.$3" | while read -r file; do
    basename "$file"
done > "$1"