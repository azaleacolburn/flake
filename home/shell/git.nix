{
  lib,
  config,
  ...
}:
let
  cfg = config.programs.git;
  inherit (config.homeConf.git) userName userEmail;
in
{
  config.programs = lib.mkIf cfg.enable {
    git = {
      inherit userName userEmail;
      lfs.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        commit.gpgsign = true;
        gpg.format = "ssh";
        core.editor = "nvim";
        pull.rebase = true;
      };
      includes = [
        {
          condition = "hasconfig:remote.*.url:git@github.com*/**";
          contents = {
            user.signingKey = "~/.ssh/github_ed25519.pub";
          };
        }
        {
          condition = "hasconfig:remote.*.url:git@codeberg.org*/**";
          contents = {
            user.signingKey = "~/.ssh/codeberg_ed25519.pub";
          };
        }
      ];
    };
  };
}
