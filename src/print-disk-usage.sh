#!/usr/bin/env bash
source "src/colors.sh"
source "src/common.sh"
# source : https://www.gilesorr.org/blog/disk-free-tui.html
# filename: dft

declare -A mppcent
declare -A mpsize
declare -A mpused

while read -r mountpoint
do
    # the weird "+ 0" math operation is to turn a String into an Integer ...
    mppcent["${mountpoint}"]=$(( $( df --output=pcent "${mountpoint}" | tail -n +2 | tr -d '%' ) + 0 ))
    mpsize["${mountpoint}"]="$( df --output=size -h "${mountpoint}" | tail -n +2 | tr -d ' ' )"
    mpused["${mountpoint}"]="$( df --output=used -h "${mountpoint}" | tail -n +2 | tr -d ' ' )"
done < <( echo "/" )
# $COLUMNS isn't available in scripts, so:
for mp in "${!mppcent[@]}"
do
    printf "$fmt" "Disk Usage" "${mpused["${mp}"]}/${mpsize["${mp}"]}, ${mppcent["${mp}"]}%"

    fillcols=$(( barWidth * ${mppcent["${mp}"]} / 100 ))

    cacheFillcols=0
    if [[ -n "$grandTotal" ]] && (( grandTotal > 0 )); then
        diskSizeBytes=$(df --output=size -B1 "${mp}" | tail -n +2 | tr -d ' ')
        if (( diskSizeBytes > 0 )); then
            cacheFillcols=$(( (barWidth * grandTotal + diskSizeBytes / 2) / diskSizeBytes ))
            (( cacheFillcols == 0 )) && cacheFillcols=1
            (( cacheFillcols > fillcols )) && cacheFillcols=$fillcols
        fi
    fi

    echo -en "${color}"
    i=1
    while [ ${i} -le ${barWidth} ]
    do
        if   [ ${i} -eq $(( fillcols - cacheFillcols + 1 )) ] && (( cacheFillcols > 0 )); then
            echo -en "${cacheColor}"
        elif [ ${i} -eq $(( fillcols + 1 )) ]; then
            echo -en "${emptyColor}"
        fi
        echo -n "${fillCharacter}"
        (( i++ ))
    done
    echo -e "${reset}"
done
