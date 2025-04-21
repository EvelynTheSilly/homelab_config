{
  virtualisation.oci-containers.containers.pihole = {
    image = "pihole/pihole:latest"; # 🔁 Change this per service
    ports = [
        # DNS Ports
        "53:53/tcp"
        "53:53/udp"
        # Default HTTP Port
        "80:80/tcp"
        # Default HTTPs Port. FTL will generate a self-signed certificate
        "443:443/tcp"
        # Uncomment the line below if you are using Pi-hole as your DHCP server
        #"67:67/udp"
        # Uncomment the line below if you are using Pi-hole as your NTP server
        #"123:123/udp"
    ];
    environment = {
        TZ = "Europe/London";
        FTLCONF_webserver_api_password = "correct horse battery staple";
        FTLCONF_dns_listeningMode = "all";
    };
    volumes = [
        "./etc-pihole:/etc/pihole"
    ];
    capabilities = {
        NET_ADMIN = true;
        SYS_TIME = true;
        SYS_NICE = true;
    };

    autoStart = true;
  };
}
