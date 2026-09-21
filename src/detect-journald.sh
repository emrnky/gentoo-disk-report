#!/usr/bin/env bash
source "src/common.sh"
getJournaldPath() {
    is_cmd journalctl || return
    find /var/log/journal -name '*.journal' 2>/dev/null
}

mapfile -t journaldPaths < <(getJournaldPath)
# journaldTotal 
# journalctl --disk-usage | awk '{print $(NF-4)}' | numfmt --from=iec
