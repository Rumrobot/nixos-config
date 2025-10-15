{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nixosConfig.environment.shells;
  shells = cfg;

  defaultShells = lib.attrValues (
    lib.filterAttrs (name: value: value ? default && value.default) shells
  );

  defaultShell =
    if defaultShells == []
    then null
    else builtins.head defaultShells;

  hasDefaultShell = defaultShell != null;
in {
  imports = [
    ./zsh.nix
  ];

  options.nixosConfig.environment.shell = {
    package = mkOption {
      type = types.package;
    };
    name = mkOption {
      type = types.str;
    };
  };

  config = mkIf hasDefaultShell {
    nixosConfig.environment.shell = {
      package = defaultShell.package;
      name = defaultShell.name;
    };

    users.defaultUserShell = defaultShell.package;

    assertions = [
      {
        assertion = lib.length defaultShells <= 1;
        message = "You have more than one default shell: ${lib.concatStringsSep " " (lib.map (br: br.name) defaultShells)}";
      }
    ];
  };
}
