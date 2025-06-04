{ pkgs, pkgs-unstable, inputs, system, ... }: {
  # Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    # xwayland.enable = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    waybar
    # eww # Elkowars's wacky widgets
    mako # Notifications daemon
    swww # Wallpaper daemon
    rofi-wayland # APP launcher
    kitty # Required for hyprland config
  ];

  environment.sessionVariables = {
    # Invisible cursor fix
    # WLR_NO_HARDWARE_CURSORS = "1";
   
    # Use wayland with electron apps
    NIXOS_OZONE_WL = "1";
  };

  # Hardware setup
  hardware = {
    graphics = {
      enable = true;
      package = pkgs-unstable.mesa;
    
      # 32-bit support
      # enable32Bit = true;
      # package32 = pkgs-unstable.pkgsi686Linux.mesa;
    };
    # nvidia.modesetting.enable = true;
  };
}
