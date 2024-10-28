#!/bin/sh
echo -ne '\033c\033]0;Space Rocks\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Space Rocks.x86_64" "$@"
