{
  virtualisation.oci-containers.containers.my-container = {
    image = "foo/bar:latest"; # 🔁 Change this per service
    ports = [
    ];
    environment = {
    };
    volumes = [
    ];
    extraOptions = ["--network=caddy"];
    autoStart = true;
  };
}
