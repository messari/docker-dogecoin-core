#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for dogecoind"

  set -- dogecoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "dogecoind" ]; then
  mkdir -p "$DOGECOIN_DATA"
  chmod 700 "$DOGECOIN_DATA"
  chown -R dogecoin "$DOGECOIN_DATA"

  echo "$0: setting data directory to $DOGECOIN_DATA"

  set -- "$@" -datadir="$DOGECOIN_DATA"
fi

if [ "$1" = "dogecoind" ] || [ "$1" = "dogecoin-cli" ] || [ "$1" = "dogecoin-tx" ]; then
  echo
  exec gosu dogecoin "$@"
fi

echo
exec "$@"
