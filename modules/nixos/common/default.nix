{
  lib,
  config,
  ...
}: let
  cfg = config.internal.modules.common;
in {
  imports = [
    ./packages.nix
  ];

  options.internal.modules.common = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    internal.modules.common.packages.enable = lib.mkDefault true;
  };
}
