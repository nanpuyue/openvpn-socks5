#!/bin/bash

openvpn --script-security 2 --up /etc/openvpn/update-resolv-conf --auth-nocache\
    --cd "$PWD" --config "$OVPN" 2>&1 | sed 's/^/[openvpn] /g' &
OVPNPID="$!"

while kill -0 "$OVPNPID" >/dev/null 2>&1; do
    sleep 0.5
    [ -d /sys/devices/virtual/net/tun0 ] && break
done || exit 1

sock5s -l 0.0.0.0:1080 2>&1 | sed 's/^/[sock5s] /g'
