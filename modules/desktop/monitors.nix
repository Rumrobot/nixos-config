{ lib, ... }:
with lib; let
  monitorModule = types.submodule {
    options = {
      id = mkOption {
        type = types.str;
        description = "Monitor identifier (hyprctl monitors -> '[make] [model]')";
        example = "Samsung Display Corp. 0x4193";
      };

      width = mkOption {
        type = types.int;
        description = "Width [px]";
        example = 1920;
      };

      height = mkOption {
        type = types.int;
        description = "Height [px]";
        example = 1080;
      };

      refreshRate = mkOption {
        type = types.either types.int types.float;
        description = "Refresh rate [Hz]";
        example = 60.0;
      };

      position = mkOption {
        type = types.submodule {
          options = {
            x = mkOption {
              type = types.int;
              default = 0;
              description = "X position [px]";
            };
            y = mkOption {
              type = types.int;
              default = 0;
              description = "Y position [px]";
            };
          };
        };
        default = {
          x = 0;
          y = 0;
        };
        description = "Position";
      };

      scale = mkOption {
        type = types.either types.int types.float;
        default = 1;
        description = "Scale factor [%]";
        example = 1.5;
      };

      rotation = mkOption {
        type = types.int;
        default = 0;
        description = "Rotation [0=0°, 1=90°, 2=180°, 3=270°]";
      };

      enabled = mkOption {
        type = types.bool;
        default = true;
        description = "Whether this monitor is enabled";
      };
    };
  };
in {
  options.nixosConfig.desktop.monitors = mkOption {
    type = types.listOf monitorModule;
    default = [];
    description = "List of monitor configurations";
    example = literalExpression ''
      [
        {
          id = "Samsung Display Corp. 0x4193";
          width = 2880;
          height = 1800;
          refreshRate = 90.0;
          position = { x = 0; y = 0; };
          scale = 1.5;
          rotation = 0;
        },
        ...
      ]
    '';
  };
}
