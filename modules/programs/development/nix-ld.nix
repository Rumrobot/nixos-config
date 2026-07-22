{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.development.nix-ld";

  options = with delib;
    moduleOptions ({myconfig, ...}: {
      # Currently only fvm needs this; TODO: figure out when to enable
      enable = boolOption myconfig.programs.development.android.enable;
    });

  nixos.ifEnabled.programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };
}
