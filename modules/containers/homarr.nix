{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.container_homarr = {...}: {
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
  };
}
