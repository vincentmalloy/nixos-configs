{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.gui.desktop-environment.waybar;
in {
  options.internal.modules.gui.desktop-environment.waybar = {
    enable = lib.mkEnableOption "waybar config";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      style =
        # css
        ''
          window#waybar {
            background: @theme_base_color;
            border-bottom: 1px solid @unfocused_borders;
            color: @theme_text_color;
          }

          #pulseaudio-slider trough {
            min-width: 100px;
            background-color: @unfocused_borders;
          }
          #pulseaudio-slider highlight {
            min-width: 1px;
            background-color: @theme_text_color;
          }
          #pulseaudio-slider slider {
            background-color: @theme_text_color;
          }
        '';
      settings = let
        allBars = {
          reload_style_on_change = true;
          # layer = "bottom";
        };
      in {
        mainBar =
          allBars
          // {
            output = "HDMI-A-1";

            modules-left = [
              "hyprland/workspaces"
            ];
            modules-right = [
              "pulseaudio/slider"
              "tray"
              "clock"
            ];
            modules-center = [
              "hyprland/window"
            ];
            "pulseaudio/slider" = {
              min = 0;
              max = 100;
              orientation = "horizontal";
            };
          };

        leftBar =
          allBars
          // {
            output = "DP-2";

            modules-left = [
              "hyprland/workspaces"
              "clock"
            ];
            modules-center = [
              "custom/voyager"
            ];

            "custom/voyager" = {
              format = "{}";
              max-length = 40;
              interval = 60;
              exec = pkgs.writeShellScript "distance-of-voyager" ''
                #!/usr/bin/env bash

                epoch_known="1433924220" # June 10, 2015, 10:17 UTC
                dist_known="19569051779462.6" # distance in meters at epoch_known
                speed_mps="16999.487261" # speed in meters per second
                au="149597870691"
                epoch_now=$(date +%s)
                timediff=$(bc <<< "$epoch_now - $epoch_known")
                distance=$(bc <<< "scale=5;($dist_known + ( $timediff * $speed_mps )) / $au")
                echo "󰇧    $distance AU    "
              '';
            };
          };

        rightBar =
          allBars
          // {
            output = "DP-3";
            modules-left = [
              "hyprland/workspaces"
              "hyprland/language"
            ];
            modules-right = [
              "clock"
            ];
            clock = {
              format = "{:%Y-%m-%d | %H:%M}";
            };
          };
      };
    };
  };
}
