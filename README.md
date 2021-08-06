# WPUSS

```
           W.P.U.S.S.
Web Proxy (with) Upstream SSH Socks


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
|  hard to  |   ssh socks     |   WPUSS      |
|  reach    |   proxy (8889)  |   http proxy +<---------+ client connections
|  network  +<-------<--------+   (8888)     |
|           |                 |              |
+-----------+                 +--------------+
```

## Description

This is for the occassions when you need a http proxy server to a remote system. As the proxy server created by ```ssh -D``` is a SOCKS5 proxy, it doesn't play well with a lot of applications, especially command line things.

1. You create your SSH tunnel to whatever you need to access.
2. Start up WPUSS, which will connect to your SSH tunnel.
3. Point your applications to 127.0.0.1:8888
4. PROFIT

## Steps

Build WPUSS container
```
git clone git@github.com:shaungarwood/wpuss.git
cd wpuss
build . -t wpuss
```

Run WPUSS, detached
```
docker run\
  --detach\
  -p 8888:8888\
  --name wpuss\
  wpuss 
```

You may have to add ```--network host``` depending on your host.
```
docker run\
  --detach\
  --network host\
  --name wpuss\
  wpuss 
```

Watch WPUSS logs
```docker logs -f wpuss```

Create SSH tunnel
```ssh -ND 8889 [remote server]```

Test HTTP proxy
```
curl -x "http://127.0.0.1:8888" http://prev.innaccessible.server
<HTML>
WORKS!
</HTML>
```
