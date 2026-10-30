{
  delib,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.cli.neovim";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled = {myconfig, ...}: let
    devConfig = myconfig.programs.development;
  in {
    imports = [inputs.nvf.homeManagerModules.default];

    programs.nvf = {
      enable = true;

      settings = {
        vim = {
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          navigation.harpoon.enable = true;
          filetree.neo-tree.enable = true;

          git.enable = true;

          clipboard.enable = true;

          options = {
            tabstop = 2;
            shiftwidth = 2;
            expandtab = true;
          };

          lsp = {
            enable = true;
            formatOnSave = true;
          };

          languages = {
            enableTreesitter = true;
            enableFormat = true;

            nix.enable = devConfig.nix.enable;

            typescript = {
              enable = devConfig.nodejs.enable;
              format.type = ["prettier"];
            };

            rust.enable = devConfig.rust.enable;
            typst.enable = myconfig.programs.typst.enable;
          };
        };
      };
    };
  };
}
