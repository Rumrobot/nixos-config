{
  delib,
  host,
  homeManagerUser,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "hardware.networking";

  options = with delib;
    moduleOptions {
      ssdp = boolOption false;
    };

  nixos.always = {cfg, ...}: {
    networking = {
      hostName = host.name;
      networkmanager.enable = true;

      firewall = {
        enable = true;

        checkReversePath = "loose";

        extraPackages = lib.optionals cfg.ssdp [pkgs.ipset];
        extraCommands = lib.optionalString cfg.ssdp ''
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
