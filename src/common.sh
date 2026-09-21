cols="40"
fmt="  %-${cols}s %s\n"
is_cmd(){ command -v "$1" >/dev/null 2>&1; }
# Convert bytes to du format
bytesToHooman() { numfmt --to=iec --format='%.1f' "$1"; }

camelToCaps() {
    local s
    s=$(sed -E 's/([a-z0-9])([A-Z])/\1 \2/g' <<< "$1")
    printf '%s\n' "${s^}"
}

truncatePath() {
    local p="$1" max="${2:-${cols}}" n=${#1}
    (( n <= max )) && { printf '%s\n' "$p"; return; }
    local half=$(( (max - 3) / 2 ))
    printf '%s...%s\n' "${p:0:half}" "${p: -half}"
}
