{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.homelab = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.homelabConfiguration
      self.nixosModules.user
      self.nixosModules.Certs
      self.nixosModules.containers
      self.nixosModules.ddClinet
      self.nixosModules.locale
      self.nixosModules.networking
      self.nixosModules.sshd

      self.nixosModules.container_pihole
      self.nixosModules.container_dev_container
      self.nixosModules.container_llama
      self.nixosModules.container_openwebui
      self.nixosModules.container_caddy
      self.nixosModules.container_registry
      self.nixosModules.container_personal_homepage

      inputs.sops-nix.nixosModules.sops
    ];
  };
}
