{pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    orca-slicer
    prusa-slicer
  ];
}
