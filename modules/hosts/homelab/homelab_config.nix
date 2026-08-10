{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.homelabConfiguration = { ... }: {
    networking.hostName = "homelab";

    nix.settings.experimental-features = ["nix-command" "flakes"];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    services.logind.settings = {
      Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitchExternalPower = "ignore";
      };
    };

    imports = [
      ./_hardware_configuration.nix
    ];

    services.dbus.enable = true;
  }
