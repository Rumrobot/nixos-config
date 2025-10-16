{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.mononoki
      nerd-fonts.jetbrains-mono
      roboto
      roboto-serif
    ];

    fontconfig.defaultFonts = {
      sansSerif = ["Roboto"];
      serif = ["Roboto Serif"];
      monospace = ["JetBrains Mono"];
    };
  };
}
