{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  nixosConfig.windowManagers.hyprland.enable = true;
  # NixOS system
  system.stateVersion = "25.05";

  nixosConfig.system.bootloader.device = "/dev/vda";

  # Networking
  networking.hostName = "NVM-NE";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Copenhagen";

  nixosConfig.system.keymap = {
    layout = "dk";
    variant = "winkeys";
  };



  nixosConfig.system.kvmClipboard.enable = true;
}
