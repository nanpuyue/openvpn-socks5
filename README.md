# Usage

## Shell
```bash
PORT="127.0.0.1:1082"
OVPN="example.ovpn"

docker run -it --rm --name openvpn-socks5 --device=/dev/net/tun --cap-add=NET_ADMIN \
    -p "$PORT":1080 -v "$PWD":/vpn -e OVPN="$OVPN" nanpuyue/openvpn-socks5
```

## Windows Cmd
```bat
set PORT="127.0.0.1:1082"
set OVPN="example.ovpn"

docker run -it --rm --name openvpn-socks5 --device=/dev/net/tun --cap-add=NET_ADMIN ^
    -p "%PORT%":1080 -v "%CD%":/vpn -e OVPN="%OVPN%" nanpuyue/openvpn-socks5
```

## PowerShell
```powershell
$env:PORT="127.0.0.1:1082"
$env:OVPN="example.ovpn"

docker run -it --rm --name openvpn-socks5 --device=/dev/net/tun --cap-add=NET_ADMIN `
    -p "${env:PORT}:1080" -v "${PWD}:/vpn" -e "OVPN=${env:OVPN}" nanpuyue/openvpn-socks5
```

Add the `-d` option to run as a daemon, or press `Ctrl`+`P` -> `Ctrl`+`Q` to detach.

## License
This project is licensed under the [MIT license].

[MIT license]: https://github.com/nanpuyue/openvpn-socks5/blob/master/LICENSE
