{delib}: (with delib.extensions; [
  args
  (delib.callExtension ./rice-options.nix)
  (delib.callExtension ./binds.nix)
  (base.withConfig {
    args.enable = true;

    # hosts.type.types = [
    #   "desktop"
    #   "server"
    # ];

    hosts.features = {
      # cli: Enables non-essential cli programs
      features = [
        "cli"
        "gui"
        "gaming"
        "development"
        "hacking"
        "powersave"
        "wireless"
        "vm"
        "llm"
      ];
      defaultByHostType = {
        desktop = [
          "cli"
          "gui"
          "development"
          "hacking"
        ];
        server = [];
      };
    };

    hosts.displays.enable = false;
    hosts.extraSubmodules = [
      ({config, ...}: {
        options.displays = delib.listOfOption (delib.submodule {
          options = {
            enable = delib.boolOption true;

            name = delib.noDefault (delib.strOption null);
            primary = delib.boolOption (builtins.length config.displays == 1);
            touchscreen = delib.boolOption false;

            refreshRate = delib.numberOption 60;
            width = delib.intOption 1920;
            height = delib.intOption 1080;
            x = delib.intOption 0;
            y = delib.intOption 0;
          };
        }) [];
      })
    ];
  })
  (overlays.withConfig {
    defaultTargets = [
      "nixos"
    ];
  })
])
