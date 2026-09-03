{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.container_llama = {config, ...}: {
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
      image = "ghcr.io/ggml-org/llama.cpp:server-cuda";
      ports = [
        "8080:8080"
      ];
      environment = {
      };
      volumes = ["/home/evelyn/llama/models:/models"];
      extraOptions = [
        "--network=caddy"
        "--device=nvidia.com/gpu=all"
        "--security-opt=label=disable"
      ];

      cmd = [
        "-m"
        "/models/active_model.gguf"
        "--host"
        "0.0.0.0"
        "--port"
        "8080"
        "-ngl"
        "99"
        "-c"
        "16384"
        "-np"
        "4"
      ];
      autoStart = true;
    };
  };
}
