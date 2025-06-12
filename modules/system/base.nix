{
  config,
  pkgs,
  lib,
  username,
  ...
}: let
  hasNixos = config ? environment;
in {
  options.nixosConfig.system.enable =
    lib.mkEnableOption "Base system configuration" // {default = true;};

  config = lib.mkMerge [
    (lib.mkIf hasNixos {
      users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = ["networkmanager" "wheel"];
      };

      nix.settings.trusted-users = [username];

      nix.settings = {
        experimental-features = ["nix-command" "flakes"];
      };

      nix.gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
      };

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        nano
        wget
        curl
        git
        sysstat
        lm_sensors
        neofetch
      ];
    })
  ];
}
