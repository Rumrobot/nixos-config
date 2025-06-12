{
  imports = [
    ./core.nix
    ./system/base.nix
    ./system/audio.nix
    ./system/bootloader.nix
    ./system/keymap.nix
    ./system/kvm-clipboard.nix
    ./packages/1password.nix
    ./packages/terminal.nix
    ./browsers/zen.nix
    ./windowManagers/hyprland.nix
    ./gnome.nix
  ];
}
