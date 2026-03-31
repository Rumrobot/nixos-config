{delib, ...}:
delib.rice {
  name = "niri";

  # TODO: Try out https://github.com/Darkkal44/qylock#quickshell-setup

  myconfig = {
    services.sddm.enable = true;
  };

  nixos = {cfg, ...}: {
    programs.silentSDDM = {
      enable = true;
      theme = "default";
      backgrounds.default = cfg.wallpaper;
      settings = {
        "LoginScreen".background = baseNameOf (toString cfg.wallpaper);
        "LockScreen".background = baseNameOf (toString cfg.wallpaper);
      };
    };
  };
}
