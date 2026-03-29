{delib, ...}:
delib.rice {
  name = "niri";

  myconfig = {
    services.sddm.enable = true;
  };

  nixos = {
    programs.silentSDDM = {
      enable = true;
      theme = "default";
      backgrounds.sunset-birds = ../../assets/wallpapers/sunset-birds.png;
      settings = {
        "LoginScreen".background = "sunset-birds.png";
        "LockScreen".background = "sunset-birds.png";
      };
    };
  };
}
