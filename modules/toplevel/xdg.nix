{
  delib,
  host,
  homeconfig,
  ...
}:
delib.module {
  name = "xdg";

  options.xdg = with delib; {
    enable = boolOption host.isDesktop;
    mime = {
      recommended = attrsOfOption (listOf str) {};
      associations = attrsOfOption (listOf str) {};
      removed = attrsOfOption (listOf str) {};
    };
  };

  home.ifEnabled = {cfg, ...}: {
    xdg = {
      enable = true;

      userDirs = let
        home = path: "${homeconfig.home.homeDirectory}/${path}";
        media = category: home "media/${category}";
        files = category: home "files/${category}";
      in {
        enable = true;
        createDirectories = true;

        download = home "downloads";
        pictures = media "pictures";
        documents = files "documents";
        desktop = files "desktop";
        videos = media "videos";
        music = media "music";
        publicShare = files "publicshare";
        templates = files "templates";
      };

      mimeApps = {
        enable = true;

        defaultApplications = cfg.mime.recommended;
        associations.added = cfg.mime.associations;
        associations.removed = cfg.mime.removed;
      };
    };
  };

  nixos.ifEnabled.environment.variables = {
    XDG_CACHE_DIR = "${homeconfig.home.homeDirectory}/.cache";
    XDG_CACHE_HOME = "${homeconfig.home.homeDirectory}/.cache";
    XDG_CONFIG_HOME = "${homeconfig.home.homeDirectory}/.config";
    XDG_DATA_HOME = "${homeconfig.home.homeDirectory}/.local/share";
    XDG_BIN_HOME = "${homeconfig.home.homeDirectory}/.local/bin";
  };
}
