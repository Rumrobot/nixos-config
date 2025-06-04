{ inputs, pkgs, system, ... }: {
  imports = [
    ../../home/core.nix

    ./1Password.nix
    ./browser.nix
    ./hyprland.nix
  ];

  # WM
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
  };

  # Git config
  programs.git = {
    enable = true;
    userName = "Rumrobot";
    userEmail = "46647057+Rumrobot@users.noreply.github.com";
    signing = {
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDul1CyPupXyjX+YEoh5y49GxpJr2VLQ1dsn1JB5Qk2c";
    };

    extraConfig = {
      init.defaultBranch = "main";
    };   
  };

  # Packages
  home.packages = with pkgs; [
    ghostty
  ];  
}
