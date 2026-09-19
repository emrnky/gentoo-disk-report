#!/usr/bin/env bash
source "src/detect-logrotate.sh"

shopt -s nullglob extglob

cachePaths=(
    "$HOME/.cache/*"
    "$HOME/.thumbnails/*"
    "$HOME/.thunderbird/*/Cache/*"
    "$HOME/.config/discord/Cache/*"
    "$HOME/.config/discord/Code Cache/*"
    "$HOME/.config/discord/GPUCache/*"
    "$HOME/.config/Slack/Cache/*"
    "$HOME/.config/Slack/Code Cache/*"
    "$HOME/.config/Slack/GPUCache/*"
    "$HOME/.config/Code/Cache/*"
    "$HOME/.config/Code/CachedData/*"
    "$HOME/.config/Code/Code Cache/*"
    "$HOME/.config/Code/GPUCache/*"
    "$HOME/.config/Code/CachedExtensionVSIXs/*"
    "$HOME/.config/Code/blob_storage/*"
    "$HOME/.exaile/cache/*"
    "$HOME/.exaile/covers/*"
    "$HOME/.gftp/cache/*"
    "$HOME/.miro/icon-cache/*"
    "$HOME/.googleearth/Cache/*"
    "$HOME/.googleearth/Temp/*"
    "$HOME/.icedtea/cache/*"
    "$HOME/.icedteaplugin/cache/*"
    "$HOME/.java/deployment/cache/*"
    "$HOME/.android/build-cache/*"
    "$HOME/.android/cache/*"
    "$HOME/.claude/cache/*"
    "$HOME/.claude/debug/*"
    "$HOME/.claude/plugins/cache/*"
    "$HOME/.wine/drive_c/windows/temp/*"
    "$HOME/.winetrickscache/*"
    "$HOME/.wine/drive_c/winetrickstmp/*"
    "$HOME/.macromedia/Flash_Player/#SharedObjects/*"
    "$HOME/.adobe/Acrobat/*/Cache/*"
    "$HOME/.kde/cache-*/*"
    "$HOME/.kde4/cache-*/*"
    "$HOME/.config/GIMP/*/tmp/*"
)

historyPaths=(
    "$HOME/.bash_history"
    "$HOME/.zsh_history"
    "$HOME/.local/share/fish/fish_history"
    "$HOME/.viminfo"
    "$HOME/.python_history"
    "$HOME/.pythonhist"
    "$HOME/.sqlite_history"
    "$HOME/.octave_hist"
    "$HOME/.recently-used"
    "$HOME/.recently-used.xbel"
    "$HOME/.local/share/recently-used.xbel"
)

mailJunkPaths=(
    "$HOME/.thunderbird/*/cookies.sqlite"
    "$HOME/.thunderbird/*/session.json"
    "$HOME/.thunderbird/*/signons.sqlite"
)

appLogPaths=(
    "$HOME/.xsession-errors"
    "$HOME/.xsession-errors.old"
    "$HOME/.exaile/exaile.log"
    "$HOME/.miro/miro-log"
    "$HOME/.miro/miro-log.1"
    "$HOME/.miro/miro-downloader-log"
    "$HOME/.config/Screenlets/*.log"
    "$HOME/.config/Code/logs/*"
)

trashPaths=(
    "$HOME/.local/share/Trash/files/*"
    "$HOME/.local/share/Trash/info/*"
)

desktopJunkPaths=(
    "$HOME/.kde/tmp-*/*"
    "$HOME/.kde4/tmp-*/*"
    "$HOME/.kde/share/apps/RecentDocuments/*.desktop"
    "$HOME/.kde4/share/apps/RecentDocuments/*.desktop"
    "$HOME/.local/share/RecentDocuments/*.desktop"
    "$HOME/.local/share/recently-used.xbel"
    "$HOME/.local/share/user-places.xbel.tbcache"
    "$HOME/.nautilus/metafiles/*"
    "$HOME/.nautilus/saved-session-*"
    "$HOME/.local/share/xorg/*"
)

ecleanPaths=(
    "/var/cache/binpkgs/*"
    "/var/cache/distfiles/*"
)

ecleanKernelPaths=(
    "/lib/modules/*"
    "/usr/src/*"
)

logPaths+=(
    "${logPaths[@]}"
)

scanPaths=(
    "${cachePaths[@]}"
    "${historyPaths[@]}"
    "${mailJunkPaths[@]}"
    "${appLogPaths[@]}"
    "${trashPaths[@]}"
    "${desktopJunkPaths[@]}"
    "${ecleanPaths[@]}"
    "${ecleanKernelPaths[@]}"
    "${logPaths[@]}"
)

removePaths=(
    "${cachePaths[@]}"
    "${historyPaths[@]}"
    "${mailJunkPaths[@]}"
    "${appLogPaths[@]}"
    "${trashPaths[@]}"
    "${desktopJunkPaths[@]}"
)

expandGlob() {
    local -n arr_ref="$1"
    for entry in "${arr_ref[@]}"; do
        for match in $entry; do
            [ -e "$match" ] && echo "$match"
        done
    done
}
mapfile -t scanPaths         < <(expandGlob scanPaths)
mapfile -t cachePaths        < <(expandGlob cachePaths)
mapfile -t historyPaths      < <(expandGlob historyPaths)
mapfile -t mailJunkPaths     < <(expandGlob mailJunkPaths)
mapfile -t appLogPaths       < <(expandGlob appLogPaths)
mapfile -t trashPaths        < <(expandGlob trashPaths)
mapfile -t desktopJunkPaths  < <(expandGlob desktopJunkPaths)
mapfile -t ecleanPaths       < <(expandGlob ecleanPaths)
mapfile -t ecleanKernelPaths < <(expandGlob ecleanKernelPaths)
mapfile -t logPaths          < <(expandGlob logPaths)

shopt -u nullglob extglob
