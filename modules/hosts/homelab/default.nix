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
    ];
  };
}
