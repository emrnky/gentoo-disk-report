is_cmd(){ command -v "$1" >/dev/null 2>&1; }
# Convert bytes to du format
bytesToHooman() { numfmt --to=iec --format='%.1f' "$1"; }
