# Build

```bash
docker build . -f Dockerfile -t openvpn-socks5
```

# Run

```bash
PORT=1082
OVPN="example.ovpn"

docker run -it --rm --name openvpn-socks5 --device=/dev/net/tun --cap-add=NET_ADMIN \
    -p $PORT:1080 -v "$PWD":/vpn -e OVPN="$OVPN" openvpn-socks5
```

Use `"%CD%"` instead of `"$PWD"` on Windows.

Add the `-d` option to run a daemon.
