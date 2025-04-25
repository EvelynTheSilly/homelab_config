{
  virtualisation.oci-containers.containers.cloudflared = {
    image = "cloudflare/cloudflared:latest";
    environmentFiles = [
        /home/eve/cloudflared/.env
    ];
    cmd = [ "tunnel" "--no-autoupdate" "run" "--token" "$TUNNEL_TOKEN" "--url" "http://caddy:80" ];
    extraOptions = ["--network=caddy"];
    autoStart = true;
  };
}
