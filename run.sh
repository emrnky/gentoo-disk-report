#!/bin/bash
cache=(
    "$HOME/.cache/" 
    # ...
)

clear
getDirSize() {
    du -c -h --max-depth=1 "${cache[@]}"
}

getDirSize
