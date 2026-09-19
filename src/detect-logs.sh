#!/usr/bin/env bash

getLogPath() {
    sudo cat /var/lib/misc/logrotate.status | awk -F'"' '{print $2}'
}

# mapfile -t -O "${#scanPaths[@]}" scanPaths < <(getLogPath)

mapfile -t logPaths < <(getLogPath)
