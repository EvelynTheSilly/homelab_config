{pkgs, ...}:
let Caddyfile = pkgs.writeTextFile"Caddyfile"''
    piholde.home {
        reverse_proxy pihole:80
        tls internal
    }

    jellyfin.home {
        reverse_proxy jellyfin:8096
        tls internal
    }
'';
in
{
  virtualisation.oci-containers.containers.caddy = {
    image = "foo/bar:latest"; # 🔁 Change this per service
    ports = [
        "80:80"
        "443:443"
    ];
    environment = {
    };
    volumes = [
    ];
    extraOptions = ["--network=caddy"];
    autoStart = true;
  };
}
