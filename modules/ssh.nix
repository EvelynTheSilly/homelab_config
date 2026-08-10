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
    users.users.eve.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDM4BGL6JJy6eGWzoHsYn2jWlkwXxuh2X1bzbdoRzHWi"
    ];
  };
}
