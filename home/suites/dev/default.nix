{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.dev;
in
{
  options.suites.dev = {
    enable = mkEnableOption "Install development tools";
    java.enable = mkEnableOption "Install java tools (intellij)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Rust
      rustc
      cargo
      bacon

      # C
      gcc
      gnumake

      # Webdev
      bun
      nodejs
      zola

      # Misc
      gh
      fzf

      lld
      dig
      unzip

      # Disk Burner
      caligula
    ];

    programs = {
    };
  };
}
