{ ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  # Timezone
  time.timeZone = "Europe/Copenhagen";

  # Networking
  networking.hostName = "T14-NE";
  networking.networkmanager.enable = true;

  # Config
  nixosConfig = {
    windowManagers.hyprland.enable = true;
    system = {
      keymap = {
        layout = "dk";
        variant = "latin1";
      };
    };
  };

  ne = {
    desktop.ags.enable = true;
    programs = {
      neovim.enable = true;
    };
  };
  
  # Boot
  # boot.loader.systemd-boot.enable = true;
  boot.loader = {
    # efi = {
    #   canTouchEfiVariables = true;
    #   efiSysMountPoint = "/boot/efi";
    # };
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
