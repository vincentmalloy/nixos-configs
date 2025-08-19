{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: {
  home.file = {
    "${config.xdg.dataHome}/images/desktop".source = config.internal.settings.root + /images/desktop;
  };
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      preload = [
        "${config.xdg.dataHome}/images/desktop/desktop_left.jpg"
        "${config.xdg.dataHome}/images/desktop/desktop_mid.jpg"
        "${config.xdg.dataHome}/images/desktop/desktop_right.jpg"
      ];
      wallpaper = [
        "DP-1, ${config.xdg.dataHome}/images/desktop/desktop_mid.jpg"
        "DP-2, ${config.xdg.dataHome}/images/desktop/desktop_left.jpg"
        "DP-3, ${config.xdg.dataHome}/images/desktop/desktop_right.jpg"
      ];
    };
  };
}
