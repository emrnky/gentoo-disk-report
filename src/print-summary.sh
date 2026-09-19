#!/usr/bin/env bash
source "src/paths.sh"
source "src/detect-browser.sh"

getDirSize() {
    local -n arr_ref="$1"
    du -c -h -d 0 "${arr_ref[@]}"
}

printColored() {
    local color="\033[38;2;124;88;163m"  
    local reset="\033[0m"
    printf "%b%s%b\n" "$color" "[ $1 ]" "$reset"  
    printf "%s\n" "$2"
}


printColored "Cache" "$(getDirSize cachePaths)"
printColored "Packages & Distfiles Cache" "$(getDirSize ecleanPaths)"
printColored "Kernel Cache" "$(getDirSize ecleanKernelPaths)"
printColored "Logs Cache" "$(getDirSize logPaths)"

browserCache=""
for i in "${!browserNames[@]}"; do
    [[ "${sizes[i]}" == "0.0" ]] && continue
    browserCache+="${sizes[i]}    ${browserNames[i]}"$'\n'
done
printColored "Web Browser Cache" "$browserCache"
