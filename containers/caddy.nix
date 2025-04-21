{pkgs, ...}:
let Caddyfile = pkgs.writeTextFile{
    name = "Caddyfile";
    text =
    ''
        piholde.home {
            reverse_proxy pihole:80
        }

        jellyfin.home {
            reverse_proxy jellyfin:8096
            tls internal
        }
    '';
};
in
{
  virtualisation.oci-containers.containers.caddy = {
    image = "caddy:latest";
    ports = [
        "80:80"
        "443:443"
        "443:443/udp"
    ];
    environment = {
    };
    volumes = [
        "${Caddyfile}:/etc/caddy/Caddyfile"
        "/home/eve/caddy/data:/data"
    ];
    extraOptions = ["--network=caddy"];
    autoStart = true;
  };
}
