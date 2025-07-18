{
  lib,
  cmd ? null,
  name ? cmd,
  package ? null,
}:
with lib; {
  enable = mkEnableOption "${name} terminal";
  default = mkEnableOption "Make ${name} the default terminal";

  package = mkOption {
    type = types.package;
    default = package;
  };

  cmd = mkOption {
    type = types.str;
    default = cmd;
  };

  name = mkOption {
    type = types.str;
    default = name;
  };
}
