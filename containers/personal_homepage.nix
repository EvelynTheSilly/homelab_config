{
  virtualisation.oci-containers.containers.homepage = {
    image = "registry.eve.home/homepage:latest";
    extraOptions = ["--network=caddy"];
    environment = {
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = "8000";
    }
    ;
    autoStart = true;
  };
}
