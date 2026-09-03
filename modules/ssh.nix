{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sshd = {...}: {
    # Enable the OpenSSH daemon
    services.openssh.enable = true;
    services.openssh.settings.PasswordAuthentication = true;
    services.openssh.ports = [2222];
  };
}
