{pkgs, ...}: let
  installMagnet = pkgs.writeShellScriptBin "installMagnet" ''
    #! /usr/bin/env nix-shell
    #! nix-shell -i bash -p bash

    set -euo pipefail

    USAGE="Usage: installMagnet [-o output_dir] <magnet-link>"

    # Defaults
    OUTPUT_DIR="$HOME/media/unsorted"
    SEED_TIME=60

    # Parse options
    while [[ $# -gt 0 ]]; do
      case "$1" in
        -o|--output)
          OUTPUT_DIR="$2"
          shift 2
          ;;
        -h|--help)
          echo "$USAGE"
          exit 0
          ;;
        -*)
          echo "Unknown option: $1"
          echo "$USAGE"
          exit 1
          ;;
        *)
          # First non-option argument is the magnet link
          MAGNET="$1"
          shift
          ;;
      esac
    done

    if [[ -z "${MAGNET:-}" ]]; then
      echo "Error: magnet link required"
      echo "$USAGE"
      exit 1
    fi

    mkdir -p "$OUTPUT_DIR"

    ${pkgs.aria2}/bin/aria2c \
      --enable-dht=true \
      --enable-peer-exchange=true \
      --seed-time=$SEED_TIME \
      --dir="$OUTPUT_DIR" \
      --summary-interval=0 \
      --console-log-level=warn \
      "$MAGNET" &

    echo "Download started in background to $OUTPUT_DIR"
  '';
in {
  environment.systemPackages = [installMagnet];
}
