{
  lib,
  config,
  ...
}:
let
  cfg = config.programs.ssh;
in
{
  programs.ssh = lib.mkIf cfg.enable {
    addKeysToAgent = "yes";

    matchBlocks = {
      "codeberg.org".identityFile = "${config.home.homeDirectory}/.ssh/codeberg_ed25519";
      "github.com".identityFile = "${config.home.homeDirectory}/.ssh/github_ed25519";
    };
  };
}
