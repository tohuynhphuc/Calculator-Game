#!/bin/sh
echo -ne '\033c\033]0;Calculator\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Calculator.x86_64" "$@"
