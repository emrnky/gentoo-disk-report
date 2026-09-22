#!/usr/bin/env bash

set -euo pipefail

spinner() {
  local pid=$1
  local delay=0.1
  local frames=('|' '/' '-' '\')

  while kill -0 "$pid" 2>/dev/null; do
    for frame in "${frames[@]}"; do
      printf "\r  [%s] Scanning..." "$frame"
      sleep "$delay"
    done
  done
  printf "\r  [+] Done.          \n"
}
