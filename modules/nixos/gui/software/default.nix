{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.gui.software;
in {
  options.internal.modules.gui.software = {
    enable = lib.mkEnableOption "misc. software for the gui/desktop";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      config.internal.modules.gui.browser # browser
      config.internal.modules.gui.terminal # terminal emulator
      nautilus # file browser
      geeqie # image viewer
      pinta # image editor
      zathura # pdf viewer
    ];
  };
}
