{
  delib,
  host,
  homeManagerUser,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.wireshark";

  options = delib.singleEnableOption host.hackingFeatured;

  nixos.ifEnabled = {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };

    users.users.${homeManagerUser}.extraGroups = ["wireshark"];
  };

  home.ifEnabled.home.packages = [pkgs.wireshark];
}
