{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption literalExpression types;
  inherit (config.internal.plumbing) root;
in {
  imports = [
    ./lib.nix
    # (import ./settings.nix {inherit lib config root;})
    ./nixos-configurations.nix
    ./nixos-modules.nix
  ];
  options.internal.plumbing = {
    root = mkOption {
      default = null;
      type = types.nullOr types.path;
      example = literalExpression "./.";
      description = ''
        root folder to import configurations from
      '';
    };
    lib = mkOption {};
    configurations = mkOption {};
  };
}
