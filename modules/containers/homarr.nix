{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.container_homarr = {
    config,
    ...
  }: {
    virtualisation.oci-containers.containers.homarr = {
      image = "ghcr.io/homarr-labs/homarr:latest";
      environmentFiles = [
        config.sops.secrets.homarr_env.path
      ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock" # Optional, only if you want docker integration
        "/home/evelyn/homarr/appdata:/appdata"
      ];
      extraOptions = ["--network=caddy"];
      autoStart = true;
    };
  };
}
