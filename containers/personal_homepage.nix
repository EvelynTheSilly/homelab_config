{
  virtualisation.oci-containers.containers.homepage = {
    image = "registry.eve.home/homepage:latest";
    extraOptions = ["--network=caddy"];
    autoStart = true;
  };
}
