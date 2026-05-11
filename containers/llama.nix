{config, ...}: {
  nixpkgs.config.allowUnfree = true;
  # NVIDIA container toolkit for CDI (modern GPU passthrough)
  hardware.nvidia-container-toolkit.enable = true;
  # Load nvidia driver for Xorg
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    #Beta nvidia driver, use stable for latest stable
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
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
    volumes = ["/home/eve/llama/models:/models:ro"];
    extraOptions = [
      "--network=caddy"
      "--device=nvidia.com/gpu=all"
      "--security-opt=label=disable"
    ];

    cmd = [
      "-m" "/models/active_model.gguf"
      "--host" "0.0.0.0"
      "--port" "8080"
      "-ngl" "99"
      "-c" "4096"
      "-np" "4"
    ];
    autoStart = true;
  };
}
