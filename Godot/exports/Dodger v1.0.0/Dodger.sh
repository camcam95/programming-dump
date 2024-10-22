#!/bin/sh
echo -ne '\033c\033]0;Dodger\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Dodger.x86_64" "$@"
