{
  pkgs,
  lib,
  username,
  ...
}: {
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

  # Enable CUPS to print documents
  services.printing.enable = true;

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
}
