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
      # rustup
      bacon

      # C
      gcc
      gnumake

      # Webdev
      bun
      nodejs
      zola
      biome # Might remove if I fix my nix shell configs

      # Misc
      gh
      fzf

      lld
      dig
      unzip

      # Disk Burner
      caligula

      # Diff tool
      delta

      # Terminal Multiplexer
      zellij

      home-manager
    ];

    programs = {
      helix = {
        enable = true;
        settings = {
          editor = {
            true-color = true;
            line-number = "relative";
            lsp = {
              display-messages = true;
              display-inlay-hints = true;
            };
            shell = [ "nu" ];
            statusline = {
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
          };
          keys = {
            normal = {
              space.f = "file_picker";
              space.w = ":w";
              esc = [
                "collapse_selection"
                "keep_primary_selection"
              ];
              space.q = ":q";
              # x and d are typed with the same finger
              l = "x";
              x = "l";
            };
          };

        };
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
