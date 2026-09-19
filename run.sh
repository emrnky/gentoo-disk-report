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
clear
src/print-summary.sh
echo ; echo 
src/print-disk-usage.sh
