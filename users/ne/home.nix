{ pkgs, ... }: {
  imports = [
    ../../home/core.nix
  ];  

  programs.git = {
    enable = true;
    userName = "Rumrobot";
    userEmail = "46647057+Rumrobot@users.noreply.github.com";
   
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
