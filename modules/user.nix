{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.user = {pkgs, ...}: {
    # Define user accounts
    users.users.evelyn = {
      extraGroups = ["wheel" "libvirtd" "networkmanager" "docker"];
      isNormalUser = true;
    };

    # Install some packages
    environment.systemPackages = with pkgs; [
      docker
      git
      github-cli
      networkmanager
      zellij
      aria2
      transmission_4
      cowsay
      lolcat
      figlet
    ] ++ (with inputs.nix_common.packages; [
      helix
      nushell
    ]);

    system.stateVersion = "26.05";
  };
}
