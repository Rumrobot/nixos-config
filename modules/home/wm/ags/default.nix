{
  inputs,
  lib,
  pkgs-unstable,
  system,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;
    configDir = ./.;

    extraPackages = with pkgs-unstable; [
      inputs.ags.packages.${system}.hyprland
      fzf
    ];
  };
}
