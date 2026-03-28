{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.packages";
  nixos.always = {
    environment.systemPackages = with pkgs; [
      git
      gnumake
      coreutils-full
      unzip
      p7zip
      squashfsTools

      curl
      wget

      nano
      screen

      openssl
    ];
  };
}
