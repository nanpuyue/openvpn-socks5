#!/bin/bash


UPDOWN="/etc/openvpn/update-resolv-conf"
LOCAL="$(ip --json addr show eth0 | jq --raw-output '.[0].addr_info[0].local')"

ip route add table 200 $(ip route show default)
ip rule add from "$LOCAL" lookup 200

openvpn --script-security 2 --up "$UPDOWN" --down "$UPDOWN" --auth-nocache\
    --cd "$PWD" --config "$OVPN" &
PIDS[${#PIDS[@]}]="$!"


while kill -0 "${PIDS[0]}" 2>&-; do
    sleep 1
    [ -d /sys/devices/virtual/net/tun0 ] && break
done || exit 1

echo "start sock5s"
sock5s -l "$LOCAL:1080" &
PIDS[${#PIDS[@]}]="$!"


kill_and_wait() {
    kill "${PIDS[@]}" 2>&-
    wait "${PIDS[@]}"
}

trap kill_and_wait EXIT
wait -n "${PIDS[@]}"
