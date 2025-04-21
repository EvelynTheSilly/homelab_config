{pkgs, ...}:{
  services.transmission = {
    enable = true;
    settings = {
      download-dir = "/home/eve/media/unsorted"; # Where to save content
      incomplete-dir-enabled = true;
      incomplete-dir = "/home/eve/media/incomplete";
      watch-dir-enabled = true;
      watch-dir = "/home/eve/torrents/incoming"; # Drop torrents here
      rpc-enabled = true;
      rpc-whitelist-enabled = false;
      rpc-whitelist = "127.0.0.1,192.168.*.*"; # Let LAN IPs through
      peer-port = 51413;
      umask = 2; # Make sure files are group-readable
      dht-enabled = true;
      peer-limit-global = 200;
      seedRatioLimit = 1.0;
      seedRatioLimited = true;
    };
    openRPCPort = true;
    user = "eve"; # Make sure it's your actual user
    group = "users"; # group
  };
}
