{lib, ...}: {
  programs.nixvim = {
    enable = lib.mkDefault true;
    imports = [
      ./plugins
      ./config.nix
      ./keymaps.nix
    ];
  };
}
