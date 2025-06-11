{ config, pkgs, lib, username, ... }:
let
  cfg = config.nixosConfig.system.enable;
in {
  options.nixosConfig.system.enable =
    lib.mkEnableOption "Base system configuration" // { default = true; };

  config = lib.mkIf cfg {
    # User account
    users.users.${username} = {
      isNormalUser = true;
      description = username;
      extraGroups = [ "networkmanager" "wheel" ];
    };

    nix.settings.trusted-users = [ username ];

    # NixOS configuration
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };

    nix.gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    nixpkgs.config.allowUnfree = true;

    # System packages
    environment.systemPackages = with pkgs; [
      nano
      wget
      curl
      git
      sysstat
      lm_sensors # For the 'sensors' command
      neofetch
    ];
  };
}
