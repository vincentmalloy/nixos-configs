{
  lib,
  config,
  ...
}: let
  cfg = config.internal.modules.theme;
in {
  imports = [
    ./stylix.nix
  ];

  options.internal.modules.theme = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    internal.modules.theme.stylix.enable = lib.mkDefault true;
  };
}
