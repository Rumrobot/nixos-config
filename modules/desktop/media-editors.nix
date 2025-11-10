{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pinta
    gimp3
  ];
}
