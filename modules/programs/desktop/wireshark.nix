{ delib, host, ...}:
with delib; {
  name = "programs.desktop.wireshark";

  options = delib.singleEnableOption host.hackingFeatured;

  nixos.ifEnabled = {
    programs.wireshark.enable = true;

    user.extraGroups = [ "wireshark" ];
  };
}
