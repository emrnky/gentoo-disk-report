#!/usr/bin/env bash
source "src/paths.sh"
source "src/detect-browser.sh"

getDirSize() {
    local -n arr_ref="$1"
    du -c -b -d 0 "${arr_ref[@]}"
}

printColored() {
    local color="\033[38;2;124;88;163m"  
    local reset="\033[0m"
    printf "\n\n\n%b%s%b\n\n" "$color" "[ $1 ]" "$reset"  
    printf "%s\n" "$2"
}

grandTotal=0

printCategory() {
    local label="$1" arrName="$2"
    local raw total_bytes display

    raw=$(getDirSize "$arrName")
    total_bytes=$(tail -1 <<< "$raw" | awk '{print $1}')
    grandTotal=$((grandTotal + total_bytes))

    display=$(while IFS=$'\t' read -r bytes path; do
        printf "%-40s %s\n\n" "$path" "$(numfmt --to=iec --format='%.1f' "$bytes")"
    done <<< "$raw")

    printColored "$label" "$display"
}

browserCache=""

for i in "${!browserNames[@]}"; do
    [[ "${sizes[i]}" == "0.0" ]] && continue
    browserCache+=$(printf "%-40s %s\n\n" "${browserNames[i]}" "${sizes[i]}")
    grandTotal=$((grandTotal + cacheBytes[i]))
done

printCategory "Cache Directories" cachePaths

printCategory "Eclean Directories" ecleanPaths

printCategory "Eclean-Kernel Directories" ecleanKernelPaths

printCategory "Logrotate Directories" logPaths

printColored "Web Browser Cache" "$browserCache"

printColored "Grand Total" "$(numfmt --to=iec --format='%.1f' "$grandTotal")"
