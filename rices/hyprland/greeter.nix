{delib, ...}:
delib.rice {
  name = "hyprland";

  myconfig = {
    services.sddm.enable = true;
  };

  nixos = {
    programs.silentSDDM = {
      enable = true;
      theme = "default";
    };
  };
}
