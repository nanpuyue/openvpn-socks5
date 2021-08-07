FROM rust:alpine as builder
RUN apk add --update --no-cache musl-dev
RUN cargo install --git https://github.com/nanpuyue/sock5s.git

FROM alpine:latest
COPY --from=builder /usr/local/cargo/bin/sock5s /usr/local/bin
RUN apk add --update --no-cache bash jq openresolv openvpn
ADD update-resolv-conf /etc/openvpn/update-resolv-conf

WORKDIR /vpn
EXPOSE 1080
ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
