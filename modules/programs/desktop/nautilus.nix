{
  delib,
  host,
  homeconfig,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.desktop.nautilus";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled = {
    overlays.nautilus-gstreamer.enable = true;
    services.udiskie.enable = true;
  };

  nixos.ifEnabled = {myconfig, ...}: {
    # libheif + share/thumbnailers is needed for HEIC image previews
    environment.systemPackages = with pkgs; [nautilus libheif libheif.out];
    environment.pathsToLink = ["share/thumbnailers"];

    # Portal for the GTK file picker (fixes file dialogs on Hyprland/Wayland)
    xdg.portal = lib.mkIf myconfig.gui.wayland.enable {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    services.gvfs.enable = true;
  };

  home.ifEnabled = let
    dirs = homeconfig.xdg.userDirs;
  in {
    gtk.gtk3.bookmarks = [
      "file://${dirs.download}"
      "file://${dirs.documents}"
      "file://${dirs.pictures}"
      "file://${dirs.videos}"
      "file://${dirs.music}"
    ];
  };

  myconfig.ifEnabled = {
    xdg.mime.recommended = {
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
    };
  };
}
