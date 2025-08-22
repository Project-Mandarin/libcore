#!/usr/bin/env bash

set -e

COMMIT_SING_BOX="01b72e129794acae89e1c7929d0ba5a63b0e67f8"
COMMIT_LIBNEKO="1c47a3af71990a7b2192e03292b4d246c308ef0b"

if [[ -d ../../sing-box ]]; then
  if [[ "$(git -C ../../sing-box rev-parse HEAD)" != "$COMMIT_SING_BOX" ]]; then
    echo "ERROR: Wrong 'sing-box' commit hash!"
  fi
else
  mkdir -v ../../sing-box && cd ../../sing-box
  git clone --no-checkout https://github.com/MatsuriDayo/sing-box "$(pwd)"
  git -c advice.detachedHead=false checkout "$COMMIT_SING_BOX"
  cd - &>/dev/null
fi

if [[ -d ../../libneko ]]; then
  if [[ "$(git -C ../../libneko rev-parse HEAD)" != "$COMMIT_LIBNEKO" ]]; then
    echo "ERROR: Wrong 'libneko' commit hash!"
  fi
else
  mkdir -v ../../libneko && cd ../../libneko
  git clone --no-checkout https://github.com/MatsuriDayo/libneko "$(pwd)"
  git -c advice.detachedHead=false checkout "$COMMIT_LIBNEKO"
  cd - &>/dev/null
fi
