{
  config,
  lib,
  ...
}: let
  cfg = config.internal.modules.gui.software.kitty;
in {
  options.internal.modules.gui.software.kitty = {
    enable = lib.mkEnableOption "kitty terminal emulator cfg";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        cursor_trail = 3;
      };
      extraConfig = ''
        modify_font cell_height 110%
      '';
    };
  };
}
