{pkgs, ...}: {
  nixpkgs.overlays = [
    (import ./sunpaper.nix)
  ];
}
