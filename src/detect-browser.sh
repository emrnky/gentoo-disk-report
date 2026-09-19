#!/usr/bin/env bash
# git clone git@github.com:emrnky/browser_cleanup_tools.git 
# cd browser_cleanup_tools
# chmod +x *.sh lib/*.sh 

browserTools="browser_cleanup_tools"
json=$("$browserTools/disk-report.sh" --json)

mapfile -t browserNames  < <(grep -oP '"app": "\K[^"]+' <<< "$json")
mapfile -t cacheBytes    < <(grep -oP '"cache_bytes": \K[0-9]+' <<< "$json")

scripts=()
sizes=()
for i in "${!browserNames[@]}"; do
    scripts+=("clean-$(awk '{print tolower($1)}' <<< "${browserNames[i]}").sh")
    sizes+=("$(numfmt --to=iec --format='%.1f' "${cacheBytes[i]}")")
done

for i in "${!browserNames[@]}"; do
    printf '%-20s %-20s %s\n' "${scripts[i]}" "${browserNames[i]}" "${sizes[i]}"
done
