{lib, ...}:
let
    readkey = builtins.readFile /home/eve/homarr-key;
in
{
  # imports = ["${unstable-packages}/nixos/modules/virtualisations/oci-containers"];
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/homarr-labs/homarr:latest";
    ports = [
        "7575:7575"
    ];
    environment = {
        SECRET_ENCRYPTION_KEY = lib.strings.removeSuffix "\n" readkey;
    };
    volumes = [
        "/var/run/docker.sock:/var/run/docker.sock" # Optional, only if you want docker integration
        "/home/eve/homarr/appdata:/appdata"
    ];
    extraOptions = ["--network=caddy"];
    autoStart = true;
  };
}
