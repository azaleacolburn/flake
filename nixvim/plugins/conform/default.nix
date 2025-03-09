{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    prettierd
    google-java-format
    black
    stylua
    nixfmt-rfc-style
    rustfmt
    shfmt
    clang-tools
  ];

  autoCmd = [
    {
      event = "BufWritePre";
      pattern = "*";
      callback = {
        __raw = ''
          function(args)
            require("conform").format({ bufnr = args.buf })
          end
        '';
      };
    }
  ];

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>l";
      action =
        # lua
        ''
          function()
            conform.format({
              lsp_fallback = true,
              async = true,
            })
          end
        '';
    }
  ];

  plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts = {
        lsp_format = "fallback";
        timeout_ms = 1000;
      };
      formatters_by_ft =
        let
          prettier = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
        in
        {
          html = prettier;
          css = prettier;
          javascript = prettier;
          javascriptreact = prettier;
          typescript = prettier;
          typescriptreact = prettier;
          markdown = prettier;
          java = [ "google-java-format" ];
          python = [ "black" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          rust = [ "rustfmt" ];
          bash = [ "shfmt" ];
          zsh = [ "shfmt" ];
          sh = [ "shfmt" ];
          c = [ "clangd" ];
          cpp = [ "clangd" ];
          "_" = [ "trim_whitespace" ];
        };
    };
  };
}
