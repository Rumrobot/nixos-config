{ config, lib, inputs, username, ... }:
with lib; let 
  cfg = config.nixosConfig.programs.neovim;
  nvf-hmModule = inputs.nvf.homeManagerModules.default;
in {
  options.nixosConfig.programs.neovim = {
    enable = mkEnableOption "neovim editor";
  };

  config = {
      home-manager.users.${username} = {
      imports = [ nvf-hmModule ];
      
      # Needed for nixd 
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      programs.nvf = {
        enable = cfg.enable;
      
        settings = {
          vim = {
            telescope.enable = true;
            autocomplete.nvim-cmp.enable = true;
            navigation.harpoon.enable = true;
            filetree.neo-tree.enable = true;

            options = {
              tabstop = 2;
              shiftwidth = 2;
              expandtab = true;
            };

            lsp.enable = true;
            languages = {
              enableTreesitter = true;
              enableFormat = true;

              nix = {
                enable = true;
                lsp = {
                  enable = true;
                  server = "nixd";
                  options = {
                    nixos.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${username}.options";
                    home-manager.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${username}.options.home-manager.users.type.getSubOptions []";
                  };
                };
                format.type = "alejandra";
              };

              ts = {
                enable = true;
                format.type = "prettierd";
              };

              rust.enable = true;
            };
          };
        };
      };
    };
  };
}
