# Formatting
col_1="40"
col_2=20
fmt="  %-${col_1}s %${col_2}s\n"
barWidth=$(( col_1 + col_2 ))
# fmt="  %-${cols}s %s\n"

# Config 
defaultConfigFile="default.conf"
userConfigFile="$HOME/.config/gentoo-disk-report/dirs.conf"

if [[ ! -f "$userConfigFile" ]]; then
    mkdir -p "$(dirname "$userConfigFile")"
    cp "$defaultConfigFile" "$userConfigFile"
fi

configFile="$userConfigFile"

# Helpers
is_cmd(){ command -v "$1" >/dev/null 2>&1; }

bytesToHooman() { numfmt --to=iec --format='%.1f' "$1"; }

expandGlob() {
    local -n arr_ref="$1"
    for entry in "${arr_ref[@]}"; do
        for match in $entry; do
            echo "$match"
        done
    done
}

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
