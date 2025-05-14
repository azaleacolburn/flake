{ ... }:
{
  plugins = {
    lsp-signature.enable = true;
    trouble = {
      enable = true;
      settings.auto_close = true;
    };
    lsp = {
      enable = true;
      keymaps = {
        diagnostic = {
          "<leader>n" = "goto_next";
          "<leader>p" = "goto_prev";
        };
        lspBuf = {
          K = "hover";
          gi = "implementation";
          gd = "definition";
          gD = "declaration";
          gt = "type_definition";
          "<leader>ca" = "code_action";
        };
        extra = [
          {
            action = "<CMD>LspStop<Enter>";
            key = "<leader>lx";
          }
          {
            action = "<CMD>LspStart<Enter>";
            key = "<leader>ls";
          }
          {
            action = "<CMD>LspRestart<Enter>";
            key = "<leader>lr";
          }
        ];
      };
      preConfig = ''
        -- Make diagnostics less intrusive
        vim.diagnostic.config({ signs = false, virtual_text = true})
      '';
      servers = {
        # system
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        zls.enable = true;
        clangd.enable = true;

        # webdev
        ts_ls.enable = true;
        tailwindcss.enable = true;
        svelte.enable = true;
        ruff.enable = true;
        jsonls.enable = true;
        html.enable = true;
        emmet_ls = {
          enable = true;
          filetypes = [
            "html"
            "css"
            "jsx"
            "tsx"
            "svelte"
          ];
        };
        cssls.enable = true;
        htmx.enable = true;

        # config
        yamlls.enable = true;
        dockerls.enable = true;

        bashls.enable = true;
        nixd = {
          enable = true;
          settings.formatting.command = [ "nixfmt" ];
        };
        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };

        # misc
        gopls = {
          enable = true;
          autostart = true;
        };
        java_language_server.enable = true;

        marksman.enable = true;
      };
    };
  };
}
