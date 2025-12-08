{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Jetbrains
    jetbrains.webstorm
    jetbrains.pycharm-community
    jetbrains.phpstorm

    # Others
    vscode
    android-studio
  ];
}
