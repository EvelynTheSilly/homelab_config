{
  virtualisation.oci-containers.containers.plex = {
    image = "lscr.io/linuxserver/plex:latest";
    autoStart = true;
    volumes = [
      "/home/eve/plex/library:/config"
      "/home/eve/plex/tv:/tv"
      "/home/eve/plex/movies:/movies"
    ];
    environment = {
      TZ = "Europe/London";
      PUID = "1000";
      PGID = "100";
      VERSION = "docker";
    };
    #ports = ["8096:8096"]; # Optional if using host networking
    extraOptions = ["--network=host" "--read-only=true"]; # Important!
  };
}
