{...}: {
  nixpkgs.overlays = [
    (import ./sunpaper.nix)
  ];
}
