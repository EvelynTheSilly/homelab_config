{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.locale = {...}: {
    # im brittish (tragic)

    # Set your time zone.
    time.timeZone = "Europe/London";
    # Enter keyboard layout
    services.xserver.xkb.layout = "us";
  };
}
