{
  delib,
  host,
  homeManagerUser,
  pkgs,
  ...
}:
delib.module {
  name = "hardware.networking";

  nixos.always = {
    networking = {
      hostName = host.name;
      networkmanager.enable = true;

      firewall = {
        enable = true;

        allowedUDPPorts = [
          2021 # Bambu Lab SSDP discovery
          5353 # mDNS (Avahi)
        ];

        # Multicast SSDP UDP
        extraPackages = [pkgs.ipset];
        extraCommands = ''
          if ! ipset --quiet list upnp; then
            ipset create upnp hash:ip,port timeout 3
          fi
          iptables -A OUTPUT -d 239.255.255.250/32 -p udp -m udp --dport 1900 -j SET --add-set upnp src,src --exist
          iptables -A nixos-fw -p udp -m set --match-set upnp dst,dst -j nixos-fw-accept
        '';
      };
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    users.users.${homeManagerUser}.extraGroups = ["networkmanager"];
  };
}
