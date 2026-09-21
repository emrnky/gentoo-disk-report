#!/usr/bin/env bash
source "src/common.sh"

getEcleanPaths() {
    is_cmd eclean-dist || return
    echo "/var/cache/binpkgs/*"
    echo "/var/cache/distfiles/*"
}

getEcleanKernelPaths() {
    is_cmd eclean-kernel || return
    echo "/lib/modules/*"
    echo "/usr/src/*"
}

mapfile -t ecleanPaths < <(getEcleanPaths)
mapfile -t ecleanKernelPaths < <(getEcleanKernelPaths)
