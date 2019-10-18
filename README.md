# P.U.T.

```
               P.U.T.
(http) Proxy (with) Upstream (ssh) Tunnel


            ┌──────────┐
            |          |
            └─        ─┘
              |      |
              |      |
              |      |
```

## Description

Yes, the acronym was a stretch. I didn't know what else to call it.

This is for the occassions when you need a http proxy server to a remote system. As the proxy server created by ```ssh -D``` is a SOCKS5 proxy, it doesn't play well with a lot of applications, especially command line things.

## Steps

okay, spin your own tinyproxy docker
bind port 8888:8888
modify the tinproxy.conf with:
  upstream socks5 localhost:8889

echo "tinyproxy started"
echo "now start ssh socks proxy like: ssh -ND 8889 [remote server]"
echo "or from a remote system: ssh -R 8889:localhost:22 [system w/ tinyproxy]"
