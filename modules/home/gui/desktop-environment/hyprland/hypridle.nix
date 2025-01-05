{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    brightnessctl
  ];
  services.hypridle = {
    enable = true;
    settings = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # {
        #   timeout = 3600;
        #   on-timeout = "systemctl suspend";
        # }
      ];
    };
  };
}
