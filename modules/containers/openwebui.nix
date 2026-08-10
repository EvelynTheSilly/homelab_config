{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.container_openwebui = {...}: {
    virtualisation.oci-containers.containers.openwebui = {
      image = "ghcr.io/open-webui/open-webui:main";
      ports = [
        "3010:8080"
      ];
      volumes = [
        "/home/eve/open_web_ui:/app/backend/data"
      ];
      extraOptions = ["--network=caddy" "--add-host=host.docker.internal:host-gateway"];
      autoStart = true;
    };
  };
}
