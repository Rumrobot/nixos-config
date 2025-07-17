{ lib, ... }:
with lib; {
  options.nixosConfig.system = {
    hostname = mkOption {
      type = types.str;
    }; 
  };
}

