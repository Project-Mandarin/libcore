#!/usr/bin/env bash

set -e

source ./env.sh

bash ./sources.sh

if [ -z "$GOPATH" ]; then
    GOPATH=$(go env GOPATH)
fi

PATH="$PATH:$GOPATH/bin"

# Install gomobile
if [ ! -f "$GOPATH/bin/gomobile-matsuri" ]; then
  git clone https://github.com/MatsuriDayo/gomobile ../gomobile
  cd ../gomobile
  go install -v ./cmd/gomobile/
  cd - &>/dev/null && rm -rf ../gomobile
  mv -v "$GOPATH/bin/gomobile" "$GOPATH/bin/gomobile-matsuri"
fi

gomobile-matsuri init

cd ..

go get -v golang.org/x/mobile@v0.0.0-20231108233038-35478a0c49da
gomobile-matsuri bind -v \
                      -androidapi 21 \
                      -trimpath \
                      -ldflags='-s -w' \
                      -tags='with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api,with_ech' .

rm -v "$GOPATH/bin/gomobile-matsuri" "$GOPATH/bin/gobind" libcore-sources.jar
