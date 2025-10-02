#!/usr/bin/env bash

set -e

COMMIT_SING_BOX="01b72e129794acae89e1c7929d0ba5a63b0e67f8"
COMMIT_LIBNEKO="1c47a3af71990a7b2192e03292b4d246c308ef0b"
SCRIPT_DIR="$(dirname $(readlink -f $0))"

if [[ -d "$SCRIPT_DIR/../sing-box" ]]; then
  if [[ "$(git -C "$SCRIPT_DIR/../sing-box" rev-parse HEAD)" != "$COMMIT_SING_BOX" ]]; then
    echo "ERROR: Wrong 'sing-box' commit hash!"
  fi
else
  git clone --no-checkout https://github.com/MatsuriDayo/sing-box "$SCRIPT_DIR/../sing-box"
  git --git-dir="$SCRIPT_DIR/../sing-box/.git" -C "$SCRIPT_DIR/../sing-box" -c advice.detachedHead=false checkout "$COMMIT_SING_BOX"
fi

if [[ -d "$SCRIPT_DIR/../libneko" ]]; then
  if [[ "$(git -C "$SCRIPT_DIR/../libneko" rev-parse HEAD)" != "$COMMIT_LIBNEKO" ]]; then
    echo "ERROR: Wrong 'libneko' commit hash!"
  fi
else
  git clone --no-checkout https://github.com/MatsuriDayo/libneko "$SCRIPT_DIR/../libneko"
  git --git-dir="$SCRIPT_DIR/../libneko/.git" -C "$SCRIPT_DIR/../libneko" -c advice.detachedHead=false checkout "$COMMIT_LIBNEKO"
fi
