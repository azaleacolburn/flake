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
    enableDefaultConfig = false;
    matchBlocks = {
      "codeberg.org" = {
        identityFile = "${config.home.homeDirectory}/.ssh/codeberg_ed25519";
        addKeysToAgent = "yes";
      };
      "github.com" = {
        identityFile = "${config.home.homeDirectory}/.ssh/github_ed25519";
        addKeysToAgent = "yes";
      };
    };
  };
}
