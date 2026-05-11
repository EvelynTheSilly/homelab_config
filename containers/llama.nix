{
  # NVIDIA container toolkit for CDI (modern GPU passthrough)
  hardware.nvidia-container-toolkit.enable = true;
  # Podman (OCI backend)
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # OCI container for llama.cpp server
  virtualisation.oci-containers.containers.llama-cpp = {
    image = "ghcr.io/ggml-org/llame.cp:server-cuda";
    ports = [
      "127.0.0.1:8080:8080"
    ];
    environment = {
    };
    volumes = ["/path/to/models:/models:ro"];
    extraOptions = [
      "--network=caddy"
      "--device=nvidia.com/gpu=all"
      "--security-opt=label=disable"
    ];

    cmd = [
      "-m" "/models/your-model.gguf"
      "--host" "0.0.0.0"
      "--port" "8080"
      "-ngl" "99"
      "-c" "4096"
      "-np" "4"
    ];
    autoStart = true;
  };
}
