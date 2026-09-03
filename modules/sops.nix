{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sops = {
    config,
    ...
  }: {
    sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.secrets = {
      pihole_api_password = {};
      cloudflare_api_token = {};
      cloudflare_tunnel_token = {};
      homarr_env = {};
    };
  };
}
