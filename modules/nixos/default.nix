{
  lib,
  pkgs,
  username,
  ...
}: {
  imports = [
    ./1password.nix
    ./audio.nix
    ./bootloader.nix
    ./keymap.nix
    ./kvm-clipboard.nix
    ./hyprland.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel"];
  };

  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  nix = {
    settings = {
      trusted-users = [username];
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    nano
    wget
    curl
    git
    sysstat
    lm_sensors
  ];

  services.geoclue2.enable = true;
  services.printing.enable = true;
}
