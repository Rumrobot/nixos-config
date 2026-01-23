{ delib, host, homeManagerUser, ...}:
delib.module {
  name = "programs.desktop.wireshark";

  options = delib.singleEnableOption host.hackingFeatured;

  nixos.ifEnabled = {
    programs.wireshark.enable = true;

    users.users.${homeManagerUser}.extraGroups = [ "wireshark" ];
  };
}
