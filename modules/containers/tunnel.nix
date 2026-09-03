{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.container_tunnel = {
    config,
    ...
  }: {
    virtualisation.oci-containers.containers.cloudflared = {
      image = "cloudflare/cloudflared:latest";
      environmentFiles = [
        config.sops.secrets.cloudflare_tunnel_token.path
      ];
      cmd = ["tunnel" "--no-autoupdate" "run" "--token" "\${TUNNEL_TOKEN}" "--url" "http://caddy:80"];
      extraOptions = ["--network=caddy"];
      autoStart = true;
    };
  };
}
