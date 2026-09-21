#!/usr/bin/env bash

getLogPath() {
    logrotate -d /etc/logrotate.conf 2>&1 | grep -oP '(?<=^considering log )\S+'
}


mapfile -t logPaths < <(getLogPath)
