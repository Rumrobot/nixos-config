{
  delib,
  host,
  homeManagerUser,
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
