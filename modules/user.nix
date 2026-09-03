{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.user = {pkgs, ...}: {
    # Define user accounts
    users.users.evelyn = {
      uid = 1000;
      extraGroups = ["wheel" "libvirtd" "networkmanager" "docker"];
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDM4BGL6JJy6eGWzoHsYn2jWlkwXxuh2X1bzbdoRzHWi"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEB4Kq7+GwhE2a/5/LV+zUeSejFGwAtZTQ3qmol0t6yG"
      ];
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
