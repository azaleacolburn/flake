{...}: {
  plugins = {
    lsp-signature.enable = true;
    lint.enable = true;
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
          "<c-k>" = "signature_help";
          gi = "implementation";
          gd = "definition";
          gD = "declaration";
          gt = "type_definition";
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
      servers = {
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        ts_ls.enable = true;
        zls.enable = true;
        yamlls.enable = true;
        tailwindcss.enable = true;
        svelte.enable = true;
        ruff.enable = true;
        nixd = {
          enable = true;
          settings.formatting.command = ["alejandra"];
        };
        jsonls.enable = true;
        java_language_server.enable = true;
        html.enable = true;
        htmx.enable = true;
        cssls.enable = true;
        clangd.enable = true;
        # bashls.enable = true;
        dockerls.enable = true;
        gopls = {
          enable = true;
          autostart = true;
        };
        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };
        marksman.enable = true;
      };
    };
  };
}