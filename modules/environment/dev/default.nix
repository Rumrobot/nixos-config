{
  pkgs-unstable,
  username,
  ...
}: {
  imports = [
    ./node.nix
    ./python.nix
  ];

  virtualisation.docker.enable = true;

  home-manager.users.${username} = {
    home.packages = with pkgs-unstable; [
      go-task
    ];
  };
}
