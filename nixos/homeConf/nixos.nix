{
  lib,
  config,
  ...
}: {
  imports = [./shared.nix];

  options.homeConf.homeManager.autoImport = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.home-manager.sharedModules = [
    ./shared.nix
    {config.homeConf = with config.homeConf; {inherit username git radius gaps-in gaps-out wallpaper;};}
  ];
}
