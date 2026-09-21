#!/usr/bin/env bash
source "src/paths.sh"
source "src/detect-browser.sh"
source "src/colors.sh"
source "src/common.sh"

grandTotal=0

getDirSize() {
    for path in "$@"; do
        [ -e "$path" ] && du -b -d 0 "$path"
    done
}

printCategory() {
    local title="$1" data="$2"
    local -i total=0 rows=0
    local size label
    local fmt="  %-40s %s\n"

    [[ -z "$data" ]] && return

    printf "\n%b[ %s ]%b\n" "$color" "$(camelToCaps "$title")" "$reset"

    while IFS=$'\t' read -r size label; do
        [[ -z "$size" ]] && continue
        printf "$fmt" "$(truncatePath "$label")" "$(bytesToHooman "$size")"
        total+=size
        rows+=1
    done <<< "$data"

    (( rows > 1 )) && printf "$fmt" "total" "$(bytesToHooman "$total")" || echo
    printf "\n"

    (( grandTotal += total ))
}

printGroupSize() {
    local -n ref="$1"
    printCategory "$1" "$(getDirSize "${ref[@]}")"
}

for arrname in "${pathArrayNames[@]}"; do
    mapfile -t "$arrname" < <(expandGlob "$arrname")
    printGroupSize "$arrname"
done

printCategory "Web Browser Cache" "$browserCache"

printf "\n%b%s%b %s\n" "$color" "[ Scanning finished ]" "$reset" "$(bytesToHooman "$grandTotal")"
