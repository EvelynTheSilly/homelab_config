{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.user = {pkgs, ...}: {
    # Define user accounts
    users.users.eve = {
      extraGroups = ["wheel" "libvirtd" "networkmanager" "docker"];
      isNormalUser = true;
    };

    # Install some packages
    environment.systemPackages = with pkgs; [
      docker
      evil-helix
      git
      github-cli
      networkmanager
      zellij
      aria2
      transmission_4
      cowsay
      lolcat
      figlet
    ];

    system.stateVersion = "26.05";
  };
}
