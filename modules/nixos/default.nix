{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./1password.nix
    ./audio.nix
    # ./bootloader.nix
    ./keymap.nix
    ./kvm-clipboard.nix
    ./package-installers.nix
    ../nvf.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel" "wireshark" "dialout" "docker"];
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
  };
  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/ne/nixos-config";
  };

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

  services.udisks2.enable = true;
  home-manager.users.${username} = {
    services.udiskie = {
      enable = true;
      settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
          # replace with your favorite file manager
          file_manager = "${pkgs.xfce.thunar}/bin/thunar";
        };
      };
    };
  };
}
