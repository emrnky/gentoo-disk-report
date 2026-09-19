# Documentation : https://wiki.gentoo.org/wiki/Logrotate
# This script adds the following string
# into the below directory so that,
# logrotate can work on portage files
# /etc/logrotate.d/portage
path="/etc/logrotate.d/"

if [[ -d "$path" ]]; then
    touch "$path/portage"
    sudo tee "$path/portage" > /dev/null <<'EOF'
# /etc/logrotate.d/portage

/var/log/emerge-fetch.log {
    createolddir 755 portage portage
    olddir /var/log/portage/old
    su portage portage
    copytruncate
    missingok
}

/var/log/emerge.log {
    createolddir 755 portage portage
    olddir /var/log/portage/old
    su portage portage
    copytruncate
    missingok
}

/var/log/portage/*.log {
    su portage portage
    missingok
    nocreate
}
EOF
else
    echo "Logrotate path does not exist./Logrotate is not installed."
    echo "In order to install run:"
    echo "sudo emerge --ask app-admin/logrotate"
fi
