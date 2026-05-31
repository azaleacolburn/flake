{ ... }:
{
  imports = [
    ./apps
    ./desktop
    ./shell
    ./suites
    ./fix-xdg.nix
    ./monitors.nix
  ];

  home = {
    stateVersion = "24.05";
    sessionVariables = {
      editor = "nvim";
    };
    # Azalea set these because `nh home switch ~/flake` told her to
    # homeDirectory = "/home/azalea";
    # username = "azalea";
  };
}
