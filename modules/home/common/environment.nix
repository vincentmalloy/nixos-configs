{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.common.environment;
in {
  options.internal.modules.common.environment = {
    enable = lib.mkEnableOption "git and github config module";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "hx";
    };
  };
}
