{
  virtualisation.oci-containers.containers.homepage = {
    image = "registry/homepage:latest"; # 🔁 Change this per service
    extraOptions = ["--network=caddy"];
    autoStart = true;
  };
}
