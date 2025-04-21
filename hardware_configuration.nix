{ config, pkgs, ... }:

{
  # Conditional hardware for specific systems
  systemd.enable = !config.boot.kernelModules.contains "wifi";

  # Check for a specific architecture (e.g., a laptop with specific chipset)
  networking.wireless.enable = config.system.arch == "x86_64" && config.hardware.enableWiFi;
}
