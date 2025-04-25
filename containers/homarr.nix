{lib, ...}:
{
  # imports = ["${unstable-packages}/nixos/modules/virtualisations/oci-containers"];
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/homarr-labs/homarr:latest";
    environmentFiles = [
        /home/eve/homarr.env
    ];
    volumes = [
        "/var/run/docker.sock:/var/run/docker.sock" # Optional, only if you want docker integration
        "/home/eve/homarr/appdata:/appdata"
    ];
    extraOptions = ["--network=caddy"];
    autoStart = true;
  };
}
