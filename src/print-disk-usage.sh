#!/usr/bin/env bash
source "src/colors.sh"
# source : https://www.gilesorr.org/blog/disk-free-tui.html
# filename: dft
#fillCharacter="|"
fillCharacter="$(echo -e "\e(0a\e(B")"
emptyColor=$'\033[38;5;238m'
reset=$'\033[0m'

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
columns="$(tput cols)"

for mp in "${!mppcent[@]}"
do
    echo "Disk Usage: ${mpused["${mp}"]}/${mpsize["${mp}"]}, ${mppcent["${mp}"]}%"
    fillcols=$(( columns * ${mppcent["${mp}"]} / 100 ))
    echo -en "${color}"
    i=1
    while [ ${i} -le ${columns} ]
    do
        [ ${i} -eq $(( fillcols + 1 )) ] && echo -en "${emptyColor}"
        echo -n "${fillCharacter}"
        (( i++ ))
    done
    echo -e "${reset}"
done
