{delib, ...}:
delib.module {
  name = "gui.hyprland";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    # hardware.graphics = {
    #   enable = true;
    #   package = pkgs-unstable.mesa;
    # };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  home.ifEnabled = {
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    services.hyprpolkitagent.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;

      # Set the Hyprland and XDPH packages to null to use the ones from the NixOS module
      package = null;
      portalPackage = null;

      systemd.variables = ["--all"];
    };
  };
}
