{delib, host, homeManagerUser, ...}:
delib.module {
  name = "programs.development.android";

  options = delib.singleEnableOption host.developmentFeatured;

  nixos.ifEnabled = {
    programs.adb.enable = true;

    users.users.${homeManagerUser}.extraGroups = ["adbusers" "kvm"];
  };
}
