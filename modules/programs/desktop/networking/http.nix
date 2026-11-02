{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.networking.http";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = with pkgs; [
    # TODO: update flake when yaak CA certs are fixed; https://github.com/NixOS/nixpkgs/issues/576544
    # yaak
    httptoolkit
  ];
}
