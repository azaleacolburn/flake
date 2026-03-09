{ lib, ... }:
{
  flake.templates = lib.pipe ./. [
    builtins.readDir
    (lib.filterAttrs (_: type: type == "directory"))
    (builtins.mapAttrs (
      template: _:
      let
        path = lib.path.append ./. template;
      in
      {
        inherit (import (lib.path.append path "flake.nix")) description;
        inherit path;
      }
    ))
  ];
}
