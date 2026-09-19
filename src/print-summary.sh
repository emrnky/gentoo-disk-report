#!/usr/bin/env bash

source "src/paths.sh"
source "src/detect-browser.sh"
source "src/detect-journald.sh"
source "src/colors.sh"
source "src/common.sh"

grandTotal=0

getDirSize() {
    local -n arr_ref="$1"
    (( ${#arr_ref[@]} == 0 )) && return
    du -c -b -d 0 "${arr_ref[@]}"
}

printColored() {
    printf "\n\n\n%b%s%b\n\n" "$color" "[ $1 ]" "$reset"  
    printf "%s\n" "${2:-[Warning]: Directories do not exist/not supported.}"
}

extractTotalBytes() {
    tail -1 <<< "$1" | awk '{print $1}'
}

buildDisplay() {
    while IFS=$'\t' read -r bytes path; do
        printf "%-40s %s\n\n" "$path" "$(bytesToHooman "$bytes")"
    done <<< "$1"
}

printCategory() {
    local label="$1" arrName="$2" raw
    raw=$(getDirSize "$arrName")

    if [[ -z "$raw" ]]; then
        printColored "$label" ""
        return
    fi

    grandTotal=$((grandTotal + $(extractTotalBytes "$raw")))
    printColored "$label" "$(buildDisplay "$raw")"
}

browserCache=$(
    for i in "${!browserNames[@]}"; do
        [[ "${sizes[i]}" == "0.0" ]] && continue
        printf "%-40s %s\n\n" "${browserNames[i]}" "${sizes[i]}"
    done
    printf "%-40s %s\n\n" "total" "$(bytesToHooman "$browserCacheTotal")"
)

grandTotal=$((grandTotal + browserCacheTotal))

printCategory "Cache Directories" cachePaths
 
printCategory "History Files" historyPaths
 
printCategory "Mail Junk Files" mailJunkPaths
 
printCategory "App Log Files" appLogPaths
 
printCategory "Trash Directories" trashPaths
 
printCategory "Desktop Junk Directories" desktopJunkPaths
 
printCategory "Eclean Directories" ecleanPaths
 
printCategory "Eclean-Kernel Directories" ecleanKernelPaths
 
printCategory "Logrotate Directories" logPaths
 
printColored "Web Browser Cache" "$browserCache"
 
printColored "Journald Cache" "$(printf "%-40s %s\n\n" "total" "$(bytesToHooman $journaldCache)")"

printColored "Scanning finished..." "$(printf "%-40s %s\n\n" "total potential space" "$(bytesToHooman "$grandTotal")")"
