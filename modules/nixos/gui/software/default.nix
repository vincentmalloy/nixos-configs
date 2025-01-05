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
      gvfs # virtual file system manager (needed for nautilus mounts)
      geeqie # image viewer
      zathura # pdf viewer
    ];
  };
}
