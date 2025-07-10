{pkgs, ...}: {
  environment.systemPackages = with pkgs; [swww];
}
