#!/bin/bash

set -xe

function net::enable_wifi() {
    IF="${IF:-wlp3s0}"
    SSID="${SSID:-getbetter}"

    ip link set $IF up

    echo -n "${SSID} passphrase:"
    read -s PASSPHRASE
    echo
    wpa_supplicant -i $IF -c <(wpa_passphrase "${SSID}" "${PASSPHRASE}") -B

    sleep 5
    dhcpcd $IF
}

# Dispatch
"$@"