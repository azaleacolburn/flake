<div align="center">
  <h1>Azalea's Nix Flake</h1>

  <img alt="ci" src="https://img.shields.io/github/actions/workflow/status/azaleacolburn/flake/check.yml?label=build&color=a6e3a1&labelColor=303446&style=for-the-badge&logo=github&logoColor=a6e3a1" />
  <img alt="repo size" src="https://img.shields.io/github/repo-size/azaleacolburn/flake?color=fab387&labelColor=303446&style=for-the-badge&logo=github&logoColor=fab387" />
  <img alt="license" src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=ca9ee6&colorA=313244&colorB=cba6f7" />
  <img alt="nixos-unstable" src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=91D7E3" />
</div>

<img alt="multi-fetch" src="./docs/images/multi.png" />

<details>
  <summary>More Images</summary>

  <img alt="bacon" src="./docs/images/bacon.png" />
  <img alt="nvim" src="./docs/images/nvim.png" />
</details>

## Layout

[Dotfile layout taken from a friend of mine](https://codeberg.org/da157/nixos). Go check her's out; she has better documentation

- [hosts](https://github.com/azaleacolburn/flake/tree/main/hosts) - machine-level configs
  - [alurya](https://github.com/azaleacolburn/flake/tree/main/hosts/alurya) - desktop workstation
  - [gilarabrywn](https://github.com/azaleacolburn/flake/tree/main/hosts/gilarabrywn) - 2020 M1 macbook air
- [nixos](https://github.com/azaleacolburn/flake/tree/main/nixos) - nixos-specific config
  - [homeConf](https://github.com/azaleacolburn/flake/tree/main/nixos/homeConf) - home-manager config
  - [stylix](https://github.com/azaleacolburn/flake/tree/main/nixos/stylix) - styling config
  - [host](https://github.com/azaleacolburn/flake/tree/main/nixos/host) - nixos system config
- [home](https://github.com/azaleacolburn/flake/tree/main/home) - user-level config
  - [apps](https://github.com/azaleacolburn/flake/tree/main/home/apps) - application config (eg. slack)
  - [desktop](https://github.com/azaleacolburn/flake/tree/main/home/desktop) - desktop environment config (eg. hyprland)
  - [shell](https://github.com/azaleacolburn/flake/tree/main/home/shell) - shell config (eg. zsh)
  - [suites](https://github.com/azaleacolburn/flake/tree/main/home/shell) - groups of programs + config (eg. dev tools)
- [nixvim](https://github.com/azaleacolburn/flake/tree/main/nixvim) - nvim config ([lazy.nvim version](https://github.com/azaleacolburn/.config/tree/main/nvim))
- [media](https://github.com/azaleacolburn/flake/tree/main/media) - wallpapers, etc
