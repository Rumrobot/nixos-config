{ delib, host, homeManagerUser, ... }:
delib.module {
  name = "hardware.networking";

  nixos.always = {
    networking = {
      hostName = host.name;

      firewall.enable = true;
      networkmanager.enable = true;
    };

    users.users.${homeManagerUser}.extraGroups = [ "networkmanager" ];
  };
}
