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

### Diagram

```
+-----------+                 +--------------+
|           +<-------<--------+              |
|  hard to  |   ssh socks     |   P.U.T.     |
|  reach    |   proxy (8889)  |   http proxy +<---------+ client connections
|  network  +<-------<--------+   (8888)     |
|           |                 |              |
+-----------+                 +--------------+
```

## Description

Yes, the acronym was a stretch. I didn't know what else to call it.

This is for the occassions when you need a http proxy server to a remote system. As the proxy server created by ```ssh -D``` is a SOCKS5 proxy, it doesn't play well with a lot of applications, especially command line things.

## Steps

Build PUT container
```
git clone git@github.com:shaungarwood/put.git
cd put
build . -t put
```

Run PUT, detached
```
docker run\
  --detach\
  -p 8888:8888\
  --name put\
  put
```

Watch PUT logs
```docker logs -f put```

Create SSH tunnel
```ssh -ND 8889 [remote server]```

Test HTTP proxy
```
curl -x "http://127.0.0.1:8888" http://prev.innaccessible.server
<HTML>
WORKS!
</HTML>
```

NOTE: the proxy address is 127.0.0.1, NOT localhost
