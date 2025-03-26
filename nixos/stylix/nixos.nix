{ ... }:
{
  imports = [
    ./shared.nix
  ];

  stylix = {
    homeManagerIntegration.autoImport = true;

    targets = {
      grub.enable = false;
      console.enable = false;
    };
  };

  home-manager.sharedModules = [
    ./hm.nix
  ];
}
