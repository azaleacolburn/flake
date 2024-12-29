# Azalea's Nix Flake

[Partially stolen from a friend of mine](https://codeberg.org/awwpotato/nixos). Go check her's out; she has better documentation and a great install script

## Layout
- hosts - per-machine config
  - alurya - desktop workstation
  - gilarabrywn - 2020 macbook air
- nixos - nixos config
  - homeConf - home-manager config
  - stylix - styling config
  - host - nixos system config
- home - user-level config
  - apps - application config (eg. slack)
  - desktop - desktop environment config (eg. hyprland)
  - shell - shell config (eg. zsh)
  - suites - groups of programs + config (eg. dev tools)
- nixvim - vim config ([lazy.nvim version](https://github.com/azaleacolburn/.config/tree/main/nvim))
- media - wallpapers, etc
