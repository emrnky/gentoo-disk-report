#!/usr/bin/env bash
source "src/common.sh"

getJournaldPaths() {
    is_cmd journalctl || return
    LC_ALL=C journalctl --header 2>/dev/null | sed -n 's/^File path: //p'
}

mapfile -t journaldPaths < <(getJournaldPaths)
