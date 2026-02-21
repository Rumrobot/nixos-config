{ delib, pkgs, ... }:
delib.module {
  name = "programs.packages";
  nixos.always = {
    environment.systemPackages = with pkgs; [
      git
      gnumake
      coreutils-full
      unzip

      curl
      wget

      nano
      screen

      openssl
    ];
  };
}
