{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.programs.starship;
in
{
  programs.starship = mkIf cfg.enable {
    enableZshIntegration = mkIf config.programs.zsh.enable true;
    enableBashIntegration = mkIf config.programs.bash.enable true;

    settings = {
      add_newline = true;
      command_timeout = 500;
      format = "$directory$git_branch$git_metrics$nix_shell\n$character";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      # Disable the package module, hiding it from the prompt completely
      package.disabled = true;

      directory = {
        truncation_length = 10;
        truncate_to_repo = false;
      };

      git_metrics = {
        added_style = "bold green";
        deleted_style = "bold red";
        only_nonzero_diffs = true;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        disabled = false;
        ignore_submodules = false;
      };

      git_branch = {
        format = "[$branch(:$remote_branch)]($style) ";
      };

      git_status = {
        format = "($ahead_behind$all_status)";
        conflicted = "(=\${count})[red] ";
        ahead = "[⇡\${amount}](bold green) ";
        behind = "[⇣\${amount}](bold green) ";
        diverged = "[⇡\${ahead_count}⇣\${behind_count}](bold green) ";
        up_to_date = "";
        untracked = "[?\${count}](blue) ";
        stashed = "[\\$\${count}](blue) ";
        modified = "[!\${count}](yellow) ";
        staged = "[+\${count}](yellow) ";
        renamed = "[»\${count}](yellow) ";
        deleted = "[󰧧\${count}](red) ";
        typechanged = "";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };

      nix_shell = {
        format = "[$name]($style)";
        symbol = "❄️";
        style = "bold blue";
        impure_msg = "";
        pure_msg = "";
        unknown_msg = "";
        disabled = false;
        heuristic = false;
      };

      fill.symbol = " ";
    };
  };
}
