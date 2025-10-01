#!/usr/bin/env bash

set -e

source ./env.sh

bash ./sources.sh

if [ -z "$GOPATH" ]; then
    GOPATH=$(go env GOPATH)
fi

PATH="$PATH:$GOPATH/bin"
GOMOBILE_VERSION="v0.0.0-20231127183840-76ac6878050a"
# Install gomobile
if [ ! -f "$GOPATH/bin/gomobile" ]; then
  go get -v "golang.org/x/mobile@$GOMOBILE_VERSION"
  go install -v "$GOPATH/pkg/mod/golang.org/x/mobile@$GOMOBILE_VERSION/cmd/gomobile"
fi

gomobile init

cd ..

gomobile bind -v \
              -androidapi 21 \
              -trimpath \
              -ldflags='-s -w' \
              -tags='with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api,with_ech' .

rm -v "$GOPATH/bin/gomobile" "$GOPATH/bin/gobind" libcore-sources.jar
