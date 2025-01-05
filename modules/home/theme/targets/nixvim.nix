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
    stylix.targets.nixvim =
      if (config.stylix.targets.nixvim ? transparentBackground)
      then {
        transparentBackground = {
          main = true;
          signColumn = false;
        };
      }
      else {};
  };
}
