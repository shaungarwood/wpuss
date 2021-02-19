FROM alpine:3

MAINTAINER Shaun Garwood

RUN apk add --no-cache \
	tinyproxy=1.10.0-r3

# create ssh tunnel before or after tinyproxy setup
# ssh -ND 8889 [remote host]

RUN echo "upstream socks5 localhost:8889" >> /etc/tinyproxy/tinyproxy.conf

RUN tail /etc/tinyproxy/tinyproxy.conf

RUN echo "tinyproxy starting"
RUN echo "now start ssh socks proxy like: ssh -ND 8889 [remote server]"
RUN echo "or from a remote system: ssh -R 8889:localhost:22 [system w/ tinyproxy]"

CMD ["tinyproxy", "-d"]
