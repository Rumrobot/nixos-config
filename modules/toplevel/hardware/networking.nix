{ delib, host, ... }:
delib.module {
  name = "hardware.networking";

  nixos.always = {
    networking = {
      hostName = host.name;

      firewall.enable = true;
      networkmanager.enable = true;
    };

    user.extraGroups = [ "networkmanager" ];
  };
}
