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
    stylix.targets.firefox = {
      profileNames = [
        "default"
      ];
    };
  };
}
