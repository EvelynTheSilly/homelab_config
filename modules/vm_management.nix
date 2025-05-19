{ config, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice-gtk
    spice-protocol
    qemu
    dnsmasq
    bridge-utils
    # useful for remote graphical forwarding
    xorg.xauth
  ];

  # Needed for QEMU/KVM networking
  networking.firewall.checkReversePath = "loose"; # RPF issues with bridged networking

  # This enables default libvirt NAT networking (virbr0)
  systemd.services.libvirtd.wants = [ "network-online.target" ];
  systemd.services.libvirtd.after = [ "network-online.target" ];

  # KVM acceleration (assuming hardware supports it)
  boot.kernelModules = [ "kvm-intel" ]; # pick based on your CPU

  # Ensure spice works over SSH
  services.dbus.enable = true;
}
