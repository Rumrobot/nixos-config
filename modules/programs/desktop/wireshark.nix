{ delib, host, ...}:
delib.module {
  name = "programs.desktop.wireshark";

  options = delib.singleEnableOption host.hackingFeatured;

  nixos.ifEnabled = {
    programs.wireshark.enable = true;

    user.extraGroups = [ "wireshark" ];
  };
}
