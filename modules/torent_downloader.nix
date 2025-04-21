{ pkgs, ... }:

let
  getDoc = pkgs.writeShellScriptBin "get-doc" ''
    #!/usr/bin/env bash
    set -euo pipefail

    if [[ $# -lt 1 ]]; then
      echo "Usage: get-doc <magnet-link>"
      exit 1
    fi

    MAGNET="$1"
    DOWNLOAD_DIR="$HOME/media/docs"
    SEED_TIME=60  # in minutes

    mkdir -p "$DOWNLOAD_DIR"

    ${pkgs.aria2}/bin/aria2c \
      --enable-dht=true \
      --enable-peer-exchange=true \
      --seed-time=$SEED_TIME \
      --dir="$DOWNLOAD_DIR" \
      --summary-interval=0 \
      --console-log-level=warn \
      "$MAGNET" &

    echo "Download started in background for: $MAGNET"
  '';
in
{
  environment.systemPackages = [ getDoc ];
}
