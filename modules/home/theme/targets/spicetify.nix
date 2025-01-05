{
  lib,
  config,
  osConfig,
  ...
}:
with lib; let
  cfg = osConfig.stylix;
in {
  config = mkIf cfg.enable {
    stylix.targets =
      if config.stylix.targets ? spicetify
      then {
        spicetify.enable = false;
      }
      else {};
  };
}
