#!/usr/bin/env bash
source "src/common.sh"
source "src/detect-logrotate.sh"
source "src/detect-journald.sh"
source "src/detect-eclean.sh"

# Later add a function for sanitization of overlapping glob patterns
# e.g.
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

declare -A pathStates=()
pathOrder=()

readPathConfig() {
    local cf="$1" name state
    [[ -f "$cf" ]] || return
    while read -r name state; do
        [[ -z "$name" || "$name" == \#* ]] && continue
        [[ -v pathStates["$name"] ]] || pathOrder+=("$name")
        pathStates["$name"]="$state"
    done < "$cf"
}

readPathConfig "$defaultConfigFile"
readPathConfig "$userConfigFile"

for name in "${pathOrder[@]}"; do
    [[ "${pathStates[$name]}" != "false" ]] && pathArrayNames+=("$name")
done
