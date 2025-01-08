{
  lib,
  config,
  ...
}: let
  cfg = config.internal.modules.common;
in {
  imports = [
    ./git.nix
    ./environment.nix
  ];

  options.internal.modules.common = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    internal.modules.common.git.enable = lib.mkDefault true;
    internal.modules.common.environment.enable = lib.mkDefault true;
  };
}
