{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.container_pihole = {
    config,
    ...
  }: {
    virtualisation.oci-containers.containers.pihole = {
      image = "pihole/pihole:latest";
      ports = [
        #"80:80"
        #"443:443"
        # DNS Ports
        "53:53/tcp"
        "53:53/udp"
        # Uncomment the line below if you are using Pi-hole as your DHCP server
        #"67:67/udp"
        # Uncomment the line below if you are using Pi-hole as your NTP server
        #"123:123/udp"
      ];
      environment = {
        TZ = "Europe/London";
        FTLCONF_dns_listeningMode = "all";
      };
      environmentFiles = [
        config.sops.secrets.pihole_api_password.path
      ];
      volumes = [
        "./etc-pihole:/etc/pihole"
      ];
      extraOptions = ["--network=caddy"];
      autoStart = true;
    };
  };
}
