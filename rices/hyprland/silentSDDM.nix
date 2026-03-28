{
  delib,
  homeManagerUser,
  ...
}: let
  assetsPath = "/home/${homeManagerUser}/nixos-config/assets";
in
  delib.rice {
    name = "hyprland";

    myconfig = {
      services.sddm.enable = true;
    };

    nixos = {
      programs.silentSDDM = {
        enable = true;

        theme = "default";

        profileIcons.${homeManagerUser} = "${assetsPath}/icon.png";
      };
    };
  }
