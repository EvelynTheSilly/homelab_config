{
  pkgs,
  config,
}: let
  torrentProcessor = pkgs.writeShellScriptBin "torrent-processor" ''
    set -euo pipefail

    WATCH_DIR="/home/${config.users.users.yourUser.name}/torrents/incoming"
    DONE_DIR="/home/${config.users.users.yourUser.name}/torrents/finished"
    DOWNLOAD_DIR="/home/${config.users.users.yourUser.name}/media/docs"

    SEED_TIME_LIMIT=120  # Stop seeding after 2 hours

    mkdir -p "$DONE_DIR"

    # Process each torrent file
    for torrent in "$WATCH_DIR"/*.torrent; do
      [ -f "$torrent" ] || continue
      echo "Processing $torrent..."

      # Spawn the download process in the background
      ${pkgs.aria2}/bin/aria2c \
        --seed-time=$SEED_TIME_LIMIT \
        --seed-ratio=1.5 \
        --dir="$DOWNLOAD_DIR" \
        --summary-interval=0 \
        --console-log-level=warn \
        "$torrent" &

      # Get the process ID of the last background command
      pid=$!

      # Wait for this specific process to finish before moving the .torrent file
      wait $pid

      # Once the download is finished, move the .torrent file to the "finished" folder
      mv "$torrent" "$DONE_DIR"
    done
  '';
in {
  environment.systemPackages = [torrentProcessor];

  systemd.eve.services.torrentProcessor = {
    description = "Process incoming torrents using aria2";
    wantedBy = ["default.target"];
    script = "${torrentProcessor}/bin/torrent-processor";
  };

  systemd.eve.paths.torrentWatcher = {
    description = "Watches for new torrent files";
    wantedBy = ["default.target"];
    pathConfig = {
      PathModified = "/home/${config.users.users.eve.name}/torrents/incoming";
    };
    unitConfig = {
      Unit = "torrentProcessor.service";
    };
  };
}
