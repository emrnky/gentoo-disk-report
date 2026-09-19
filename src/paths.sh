#!/usr/bin/env bash

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
scanPaths=(
    "${cachePaths[@]}"
    "${ecleanPaths[@]}"
    "${ecleanKernelPaths[@]}"
)
removePaths=(
    "${cachePaths[@]}"
)
