{pkgs, ...}: {
  imports = [
    ./monitors.nix
    ./ags
    ./IDEs.nix
    ./social.nix
    ./slicers.nix
    ./media-editors.nix
    ./utilities.nix
  ];

  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    obsidian
  ];
}
