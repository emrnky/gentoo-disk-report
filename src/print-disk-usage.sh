#!/usr/bin/env bash
# source : https://www.gilesorr.org/blog/disk-free-tui.html
# filename: dft
#fillCharacter="|"
fillCharacter="$(echo -e "\e(0a\e(B")"

declare -A mppcent
declare -A mpsize

while read -r mountpoint
do
    # the weird "+ 0" math operation is to turn a String into an Integer ...
    mppcent["${mountpoint}"]=$(( $( df --output=pcent "${mountpoint}" | tail -n +2 | tr -d '%' ) + 0 ))
    mpsize["${mountpoint}"]="$( df --output=size -h "${mountpoint}" | tail -n +2 | tr -d ' ' )"
done < <( lsblk --output MOUNTPOINT --noheadings | grep -v '^$' | grep -v '[SWAP]' ; mount | grep " cifs " | awk '{ print $3 }' )

# $COLUMNS isn't available in scripts, so:
columns="$(tput cols)"

for mp in "${!mppcent[@]}"
do
    echo "${mp}: ${mpsize["${mp}"]}, ${mppcent["${mp}"]}%"
    fillcols=$(( columns * ${mppcent["${mp}"]} / 100 ))
    i=1
    while [ ${i} -le ${fillcols} ]
    do
        echo -n "${fillCharacter}"
        (( i++ ))
    done
    echo
done
