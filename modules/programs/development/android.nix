{delib, host, pkgs, homeManagerUser, ...}:
delib.module {
  name = "programs.development.android";

  options = delib.singleEnableOption host.developmentFeatured;

  nixos.ifEnabled = {
    users.users.${homeManagerUser}.extraGroups = ["adbusers" "kvm"];
  };

  home.ifEnabled.home.packages = [pkgs.android-tools];
}
