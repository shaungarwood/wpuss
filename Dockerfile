FROM alpine:3.7

MAINTAINER Shaun Garwood

RUN apk add --no-cache \
	tinyproxy

# create ssh tunnel before or after tinyproxy setup
# ssh -ND 8889 [remote host]

RUN echo "upstream socks5 localhost:8889" >> /etc/tinyproxy/tinyproxy.conf

RUN tail /etc/tinyproxy/tinyproxy.conf

CMD ["tinyproxy", "-d"]
