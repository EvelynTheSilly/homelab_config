{
  virtualisation.oci-containers.containers.dev = {
    image = "registry.eve.home/math_app:latest";
    extraOptions = ["--network=caddy" "--pull=always"];
    environment = {
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = "8000";
    };
    autoStart = true;
  };
}
