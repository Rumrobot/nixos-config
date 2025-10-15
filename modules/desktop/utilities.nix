{
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      angryipscanner
      wireshark
      rpi-imager
      yaak
    ];

    programs = {
      thunar.enable = true;
      wireshark.enable = true;
    };
  };
}
