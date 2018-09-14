# messari/dogecoin-core

A Dogecoin Core docker image.

[![messari/dogecoin-core][docker-pulls-image]][docker-hub-url] [![messari/dogecoin-core][docker-stars-image]][docker-hub-url] [![messari/dogecoin-core][docker-size-image]][docker-hub-url] [![messari/dogecoin-core][docker-layers-image]][docker-hub-url]

## Tags

- `1.10.0`, `latest` ([1.10.0/Dockerfile](https://github.com/messari/docker-dogecoin-core/blob/master/1.10.0/Dockerfile))

**Picking the right tag**

- `messari/dogecoin-core:latest`: points to the latest stable release available of dogecoin Core. Use this only if you know what you're doing as upgrading Dogecoin Core blindly is a risky procedure.
- `messari/dogecoin-core:<version>`: based on a slim Debian image, points to a specific version branch or release of Dogecoin Core. Uses the pre-compiled binaries which are fully tested by the Dogecoin Core team.

## What is Dogecoin?

Dogecoin is a cryptocurrency like Bitcoin, although it does not use SHA256 as its proof of work (POW). Taking development cues from Tenebrix and Litecoin, Dogecoin currently employs a simplified variant of scrypt. Learn more about [Dogecoin](https://dogecoin.com/).

## What is Dogecoin Core?

Dogecoin Core is the Dogecoin reference client and contains all the protocol rules required for the Dogecoin network to function. Learn more about [Dogecoin Core](https://github.com/dogecoin/dogecoin).

## Usage

### How to use this image

This image contains the main binaries from the dogecoin Core project - `dogecoind`, `dogecoin-cli` and `dogecoin-tx`. It behaves like a binary, so you can pass any arguments to the image and they will be forwarded to the `dogecoind` binary:

```sh
❯ docker run --rm messari/dogecoin-core \
  -printtoconsole \
  -regtest=1 \
  -rpcallowip=172.17.0.0/16 \
  -rpcauth='foo:YmFy'
```

By default, `dogecoind` will run as user `dogecoin` for security reasons and with its default data dir (`~/.dogecoin`). If you'd like to customize where `dogecoind` stores its data, you must use the `DOGECOIN_DATA` environment variable. The directory will be automatically created with the correct permissions for the `dogecoin` user and `dogecoind` automatically configured to use it.

```sh
❯ docker run -e DOGECOIN_DATA=/var/lib/dogecoind --rm messari/dogecoin-core \
  -printtoconsole \
  -regtest=1
```

You can also mount a directory in a volume under `/home/dogecoin/.dogecoin` in case you want to access it on the host:

```sh
❯ docker run -v ${PWD}/data:/home/dogecoin/.dogecoin --rm messari/dogecoin-core \
  -printtoconsole \
  -regtest=1
```


### Exposing Ports

Depending on the network (mode) the Dogecoin Core daemon is running as well as the chosen runtime flags, several default ports may be available for mapping.

Ports can be exposed by mapping all of the available ones (using `-P` and based on what `EXPOSE` documents) or individually by adding `-p`. This mode allows assigning a dynamic port on the host (`-p <port>`) or assigning a fixed port `-p <hostPort>:<containerPort>`.

Example for running a node in `mainnet` mode mapping JSON-RPC/REST and P2P ports:

```sh
docker run --rm -it \
  -p 22555:22555 \
  -p 22556:22556 \
  messari/dogecoin-core \
  -printtoconsole \
  -rpcallowip=172.17.0.0/16 \
  -rpcauth='foo:YmFy'
```

To test that mapping worked, you can send a JSON-RPC curl request to the host port:

```
curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getnetworkinfo","params":[]}' http://foo:YmFy=@127.0.0.1:19332/
```

#### Mainnet

- JSON-RPC/REST: 22555
- P2P: 22556

#### Testnet

- JSON-RPC: 44555
- P2P: 44555

#### Regest

- JSON-RPC: 44555
- P2P: 18444


## License

The [messari/dogecoin-core][docker-hub-url] docker project is under MIT license.

[docker-hub-url]: https://hub.docker.com/r/messari/dogecoin-core
[docker-layers-image]: https://img.shields.io/imagelayers/layers/messari/dogecoin-core/latest.svg?style=flat-square
[docker-pulls-image]: https://img.shields.io/docker/pulls/messari/dogecoin-core.svg?style=flat-square
[docker-size-image]: https://img.shields.io/imagelayers/image-size/messari/dogecoin-core/latest.svg?style=flat-square
[docker-stars-image]: https://img.shields.io/docker/stars/messari/dogecoin-core.svg?style=flat-square
