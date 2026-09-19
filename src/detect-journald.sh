#!/usr/bin/env bash

source "src/common.sh"

journaldCache() {
    if is_cmd journalctl; then 
        journalctl --disk-usage | awk '{print $(NF-4)}' | numfmt --from=iec
    fi
}


journaldCache=$(journaldCache)
