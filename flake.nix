{
  description = "Minimal flake for NixOS config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  inputs.unstable-packages.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.sops-nix.url = "github:Mic92/sops-nix";

  outputs = {
    nixpkgs,
    unstable-packages,
    sops-nix,
    ...
  }: {
    nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        sops-nix.nixosModules.sops
      ];
    };
  };
}
