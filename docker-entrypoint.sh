#!/bin/bash

ip route add table 200 $(ip route show default)
ip rule add from "$(ip --json addr show eth0 | jq --raw-output '.[0].addr_info[0].local')" lookup 200

openvpn --script-security 2 --up /etc/openvpn/update-resolv-conf --auth-nocache\
    --cd "$PWD" --config "$OVPN" 2>&1 | sed 's/^/[openvpn] /g' &
OVPNPID="$!"

while kill -0 "$OVPNPID" >/dev/null 2>&1; do
    sleep 0.5
    [ -d /sys/devices/virtual/net/tun0 ] && break
done || exit 1

echo "[socks5] started"
sock5s -l 0.0.0.0:1080 2>&1 | sed 's/^/[sock5s] /g'
