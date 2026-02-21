{ delib, host, pkgs, ... }:
delib.module {
  name = "programs.hacking";

  options = delib.singleEnableOption host.hackingFeatured;

  home.ifEnabled = {
    home.packages = with pkgs; [
      nmap
    ];
  };
}
