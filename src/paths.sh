#!/usr/bin/env bash
source "src/detect-logs.sh"

shopt -s nullglob extglob

cachePaths=(
    "$HOME/.cache/*" 
    "$HOME/.thumbnails/*"
)
ecleanPaths=(
    "/var/cache/binpkgs/*"
    "/var/cache/distfiles/*"
)
ecleanKernelPaths=(
    "/lib/modules/*"
    "/usr/src/*"   
)
logPaths+=(
    "${logPaths[@]}"
)
scanPaths=(
    "${cachePaths[@]}"
    "${ecleanPaths[@]}"
    "${ecleanKernelPaths[@]}"
    "${logPaths[@]}"
)
removePaths=(
    "${cachePaths[@]}"
)

expandGlob() {
    local -n arr_ref="$1"
    for entry in "${arr_ref[@]}"; do
        for match in $entry; do
            [ -e "$match" ] && echo "$match"
        done
    done
}
mapfile -t scanPaths        < <(expandGlob scanPaths)
mapfile -t cachePaths       < <(expandGlob cachePaths)
mapfile -t ecleanPaths      < <(expandGlob ecleanPaths)
mapfile -t ecleanKernelPaths < <(expandGlob ecleanKernelPaths)
mapfile -t logPaths         < <(expandGlob logPaths)

shopt -u nullglob extglob
