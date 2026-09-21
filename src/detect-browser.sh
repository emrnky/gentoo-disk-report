#!/usr/bin/env bash
# git clone git@github.com:emrnky/browser_cleanup_tools.git 
# cd browser_cleanup_tools
# chmod +x *.sh lib/*.sh 
#source "src/common.sh"

#scripts=()
#sizes=()
#for i in "${!browserNames[@]}"; do
#    scripts+=("clean-$(awk '{print tolower($1)}' <<< "${browserNames[i]}").sh")
#    sizes+=("$(bytesToHooman "${cacheBytes[i]}")")
# done
source "src/common.sh"

browserTools="browser_cleanup_tools"
json=$("$browserTools/disk-report.sh" --json)

mapfile -t browserNames  < <(grep -oP '"app": "\K[^"]+' <<< "$json")
mapfile -t cacheBytes    < <(grep -oP '"cache_bytes": \K[0-9]+' <<< "$json")

browserCacheTotal=$(grep -oP '"total_cache_bytes": \K[0-9]+' <<< "$json")

browserCache=$(
    for i in "${!browserNames[@]}"; do
        (( cacheBytes[i] == 0 )) && continue
        printf '%s\t%s\n' "${cacheBytes[i]}" "${browserNames[i]}"
    done
)
