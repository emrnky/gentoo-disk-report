#!/usr/bin/env bash
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
#   not sure to remove - search it more
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
#
# Caches taken from bleachbit debian
init-term() {
	printf '\n' # ensure we have space for the scrollbar
	  printf '\e7' # save the cursor location
	    printf '\e[%d;%dr' 0 "$((LINES - 1))" # set the scrollable region (margin)
	  printf '\e8' # restore the cursor location
	printf '\e[1A' # move cursor up
}

deinit-term() {
	printf '\e7' # save the cursor location
	  printf '\e[%d;%dr' 0 "$LINES" # reset the scrollable region (margin)
	  printf '\e[%d;%dH' "$LINES" 0 # move cursor to the bottom line
	  printf '\e[0K' # clear the line
	printf '\e8' # reset the cursor location
}

shopt -s nullglob extglob checkwinsize
# Check winsize 
(:)

trap deinit-term exit
trap init-term winch
init-term
source src/print-summary.sh
echo ; echo 
source src/print-disk-usage.sh
shopt -u nullglob extglob
