{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.networking = {pkgs, ...}: {
    systemd.services.request-fixed-ip = {
      wantedBy = ["network-online.target"];
      after = ["NetworkManager-wait-online.service"];
      serviceConfig.Type = "oneshot";
      script = ''
        ${pkgs.iproute2}/bin/ip addr replace 192.168.86.104/24 dev wlo1
        for addr in $(${pkgs.iproute2}/bin/ip -o addr show dev wlo1 primary | awk '{print $4}'); do
          [ "$addr" != "192.168.86.104/24" ] && ${pkgs.iproute2}/bin/ip addr del "$addr" dev wlo1
        done
      '';
    };

    networking = {
      firewall.allowedTCPPorts = [80 443 2222];
      networkmanager = {
        enable = true;
        dns = "none";
      }; # Easiest to use and most distros use this by default.
      nameservers = ["192.168.1.65" "1.1.1.1"];
      dhcpcd.enable = false; # Optional: disable dhcpcd if you're using NetworkManager or systemd-networkd
      useDHCP = false;
    };
  };
}
