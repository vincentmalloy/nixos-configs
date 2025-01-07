{
  config,
  lib,
  ...
}: let
  cfg = config.internal.modules.gaming.steam;
in {
  options.internal.modules.gaming.steam = {
    enable = lib.mkEnableOption "steam config";
  };

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
  };
}
