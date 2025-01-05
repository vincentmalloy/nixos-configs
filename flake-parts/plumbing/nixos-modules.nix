{config, ...}: let
  cfg = config.internal.plumbing;

  nixosModulesPath = cfg.root + /modules/nixos;
  homeModulesPath = cfg.root + /modules/home;
in {
  config = {
    flake = {
      nixosModules = cfg.lib.readModules nixosModulesPath;
      homeModules = cfg.lib.readModules homeModulesPath;
    };
  };
}
