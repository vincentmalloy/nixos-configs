{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.internal.modules.theme.stylix;
in {
  options.internal.modules.theme.stylix = {
    enable = lib.mkEnableOption "stylix theming module";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = config.internal.settings.root + /images/desktop/desktop_right.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.internal.settings.colorscheme}.yaml";
    };
  };
}
