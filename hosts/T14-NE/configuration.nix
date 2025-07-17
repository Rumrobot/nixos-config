{ inputs, config, ... }: let
  hostname = config.nixosConfig.system.hostname;
in {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
  ];
  
  # Timezone
  time.timeZone = "Europe/Copenhagen";

  # Networking
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  # Boot
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # efiInstallAsRemovable = true; # If grub fails
    };
  };

  # NixOS system - WARNING: DO NOT CHANGE
  system.stateVersion = "25.05";
}
