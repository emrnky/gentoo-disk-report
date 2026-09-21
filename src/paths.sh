#!/usr/bin/env bash
source "src/detect-logrotate.sh"

shopt -s nullglob extglob

declare -A pathGroups=(
    ["cachePaths"]="$HOME/.cache/*
        $HOME/.cache/*.sh
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

    ["ecleanPaths"]="/var/cache/binpkgs/*
        /var/cache/distfiles/*"

    ["ecleanKernelPaths"]="/lib/modules/*
        /usr/src/*"
)

pathArrayNames=(logPaths)


expandGlob() {
    local -n arr_ref="$1"
    for entry in "${arr_ref[@]}"; do
        for match in $entry; do
            echo "$match"
        done
    done
}

for key in "${!pathGroups[@]}"; do
    pathArrayNames+=("${key}Paths")
    mapfile -t "${key}Paths" <<< "${pathGroups[$key]}"
done

for arrname in "${pathArrayNames[@]}"; do
    mapfile -t "$arrname" < <(expandGlob "$arrname")
done


shopt -u nullglob extglob
