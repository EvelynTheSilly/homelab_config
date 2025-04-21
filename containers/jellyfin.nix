{
  virtualisation.oci-containers.containers.jellyfin = {
    image = "jellyfin/jellyfin:latest";
    autoStart = true;
    volumes = [
      "/var/lib/jellyfin/config:/config"
      "/var/cache/jellyfin:/cache"
      "/home/eve/media/jellyfin:/media"
    ];
    ports = ["8096:8096"]; # Optional if using host networking
    extraOptions = ["--network=host"]; # Important!
    environment = {
      TZ = "Your/Timezone";
    };
  };
}
