{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.ddClinet = {
    config,
    ...
  }: {
    services.ddclient = {
      enable = true;
      protocol = "cloudflare";
      zone = "eve.software";
      username = "token";
      passwordFile = config.sops.secrets.cloudflare_api_token.path;
      domains = ["eve.software" "*.eve.software"];
      ssl = true;
      interval = "5min";
    };
  };
}
