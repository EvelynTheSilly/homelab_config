{
  virtualisation.oci-containers.containers.homepage = {
    image = "registry.eve.home/homepage:latest";
    extraOptions = [
      "--network=caddy"
      "--pull=always"
    ];
    environment = {
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = "8000";
    };
    volumes = [
      "/home/eve/static:/workspace/homepage/webserver/static"
    ];
    autoStart = true;
  };
}
