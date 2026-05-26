{
  delib,
  host,
  homeconfig,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.nautilus";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.nautilus];

    # Portal for the GTK file picker (fixes file dialogs on Hyprland/Wayland)
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
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
