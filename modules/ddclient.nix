{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.ddClinet = {...}: {
    services.ddclient = {
      enable = true;
      protocol = "cloudflare";
      zone = "eve.software";
      username = "token";
      passwordFile = "/home/eve/.cloudflare-token";
      domains = ["eve.software" "*.eve.software"];
      ssl = true;
      interval = "5min";
    };
  };
}
