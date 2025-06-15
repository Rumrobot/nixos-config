{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  # NixOS system
  system.stateVersion = "25.05";

  # Timezone
  time.timeZone = "Europe/Copenhagen";

  # Networking
  networking.hostName = "NVM-NE";
  networking.networkmanager.enable = true;

  # Config
  nixosConfig = {
    windowManagers.hyprland.enable = true;
    system = {
      bootloader.device = "/dev/vda";
      kvm-clipboard.enable = true;
      keymap = {
        layout = "dk";
        variant = "winkeys";
      };
    };
  };
}
