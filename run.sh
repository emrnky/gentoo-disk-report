#!/bin/bash
# Safe to remove dirs in gentoo : https://wiki.gentoo.org/wiki/Knowledge_Base:Freeing_disk_space
# 
#
# eclean handles
#   /var/cache/binpkgs/
#   /var/cache/distfiles/
# eclean-kernel
#   /lib/modules/${old_kernel}
#   /usr/src/linux-${old_kernel}
#
#   /var/tmp/portage/ 
#   for above nothing handles it
#   safe to remove appearently
#
# logrotate
#   running - logrotate -v /etc/logrotate.conf
#   it will run all dirs given in :
#       /etc/logrotate.d/*
#   stripping paths for sizes : 
#       find them in : 
#           /var/lib/misc/logrotate.status
#       format : 
#           "var/log/rsync.log" 2026-9-17-11:0:0
#
# Browser Cache 

cache=(
    "$HOME/.cache/*" 
    #"$HOME/.thumbnails/"
    # eclean 
    #"/var/cache/binpkgs/"
    #"/var/cache/distfiles/"
    # eclean-kernel 
    #"/lib/modules/"
    #"/usr/src/"   
)

clear

getLogPath() {
    sudo cat /var/lib/misc/logrotate.status | awk -F'"' '{print $2}'
}

mapfile -t -O "${#cache[@]}" cache < <(getLogPath)

getDirSize() {
    du -c -h --max-depth=1 "${cache[@]}"
}

getDirSize
