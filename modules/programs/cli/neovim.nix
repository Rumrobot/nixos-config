{
  delib,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.cli.neovim";

  options = delib.singleEnableOption host.cliFeatured;

  nixos.ifEnabled = {
    # Needed for nixd
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  home.ifEnabled = {
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

            nix = {
              enable = true;
              lsp.servers = ["nixd"];
            };

            typescript = {
              enable = true;
              format.type = ["prettier"];
            };

            rust.enable = true;
          };
        };
      };
    };
  };
}
