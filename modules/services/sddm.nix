{
  delib,
  inputs,
  homeManagerUser,
  ...
}: let
  assetsPath = "/home/${homeManagerUser}/nixos-config/assets";
in
  delib.module {
    name = "services.sddm";

    options = delib.singleEnableOption false;

    nixos.always = {
      imports = [
        inputs.silentSDDM.nixosModules.default
      ];
    };

    nixos.ifEnabled = {myconfig, ...}: {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;

        # TODO: Cursor not showing with weston compositor
        settings = {
          Theme = {
            CursorTheme = myconfig.rice.cursor.name;
            CursorSize = myconfig.rice.cursor.size;
          };
        };
      };

      programs.silentSDDM = {
        profileIcons.${homeManagerUser} = "${assetsPath}/icon.png";
      };
    };
  }
