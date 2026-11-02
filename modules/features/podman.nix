{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "features.podman";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;

      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
