{
  pkgs,
  pkgs-unstable,
  username,
  ...
}: {
  home-manager.users.${username} = {
    home.packages =
      (with pkgs; [
        angryipscanner
        # rpi-imager
      ])
      ++ (with pkgs-unstable; [
        wireshark
        yaak
      ]);
  };

  programs = {
    thunar.enable = true;
    wireshark.enable = true;
  };
}
