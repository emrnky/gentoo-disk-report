#!/usr/bin/env bash
source "src/common.sh"
source "src/detect-logrotate.sh"
source "src/detect-journald.sh"
source "src/detect-eclean.sh"

# Later add a function for sanitization of overlapping glob patterns
#
# $HOME/.cache/*
# $HOME/.cache/**/*
# $HOME/.cache/*.sh

declare -A pathGroups=(
    ["cachePaths"]="$HOME/.cache/*
        $HOME/.thumbnails/*"

    ["historyPaths"]="$HOME/.bash_history
        $HOME/.zsh_history
        $HOME/.local/share/fish/fish_history
        $HOME/.viminfo
        $HOME/.python_history
        $HOME/.pythonhist
        $HOME/.sqlite_history
        $HOME/.octave_hist
        $HOME/.recently-used
        $HOME/.recently-used.xbel
        $HOME/.local/share/recently-used.xbel"
)

pathArrayNames=()

for key in "${!pathGroups[@]}"; do
    mapfile -t "$key" <<< "${pathGroups[$key]}"
done

while read -r name state; do
    [[ -z "$name" || "$name" == \#* ]] && continue
    [[ "$state" != "false" ]] && pathArrayNames+=("$name")
done < "$configFile"
