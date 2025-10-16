{...}: {
  imports = [
    ../../modules/nixos
    ../../modules
    ../../modules/desktop/hyprland
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  nixosConfig = {
    system = {
      hostname = "T14-NE";
      keymap = {
        layout = "dk";
        variant = "latin1";
        options = "caps:swapescape";
      };
    };

    desktop = {
      ags.enable = false;

      monitors = [
        {
          id = "California Institute of Technology 0x1404";
          width = 1920;
          height = 1200;
          refreshRate = 60.0;
          position = {
            x = 0;
            y = 0;
          };
          scale = 1;
          rotation = 0;
        }
      ];
    };

    environment = {
      terminals = {
        ghostty = {
          enable = true;
          default = true;
        };
      };
      shells = {
        zsh = {
          enable = true;
          default = true;
        };
      };
      dev = {
        node.enable = true;
        python.enable = true;
      };
    };

    programs = {
      neovim.enable = true;
    };
  };
}
