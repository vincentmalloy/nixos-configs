{
  lib,
  config,
  pkgs,
  inputs,
  osConfig,
  ...
}: let
  cfg = config.internal.modules.gui.desktop-environment.hyprland;
in {
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./includes
  ];

  options.internal.modules.gui.desktop-environment.hyprland = {
    enable = lib.mkEnableOption "hyprland and related tools";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = osConfig.programs.hyprland.package;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # plugins = [
      #   inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprwinwrap
      # ];
      settings = {
        ecosystem.no_update_news = true;
        # plugin.hyprwinwrap.class = "kitty-bg";
        misc = {
          "disable_hyprland_logo" = true;
          "enable_swallow" = true;
          "swallow_regex" = "^(kitty)$";
        };
        windowrulev2 = [
          "opacity 0.8,class:(Spotify)"
          # "fullscreen,class:^steam_app\\d+$"
          # "monitor $primaryMonitor,class:^steam_app_\\d+$"
          # "workspace 10,class:^steam_app_\\d+$"
          # "float,class:^steam_app_\\d+$"
          # "size 100% 100%,class:^steam_app_\\d+$"
        ];
        workspace = [
          # "10, border:false, rounding:false, gapsin:0, gapsout:0"
        ];
        xwayland = {
          "force_zero_scaling" = true;
        };
        debug.suppress_errors = false;
        exec-once = [
          "waybar"
          "hypridle"
          "udiskie"
        ];
        # "$mod" = "SUPER";
        bind =
          [
            "$mod ALT, S, execr, bloodwestbackup"
            "$mod ALT, L, execr, bloodwestbackup restore"
            "$mod, Return, exec, $terminal"
            "$mod, R, exec, pkill $launcher || $launcher --show drun"
            "$mod, E, exec, $fileManager"
            "$mod, M, exit"
            "$mod, Q, killactive"
            "$mod, B, exec, $browser"
            "$mod, V, togglefloating"
            "$mod, F, fullscreen, 1"
            # move focus
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"
            # move window
            "$mod ALT, left, movewindow, l"
            "$mod ALT, right, movewindow, r"
            "$mod ALT, up, movewindow, u"
            "$mod ALT, down, movewindow, d"
            # workspaces
            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (
              builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9
            )
          );
        bindm = [
          # move/resize windows
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        monitor = [
          "DP-1, preferred, 0x0, 1.75"
          "DP-2, preferred, auto-right, 1"
          "DP-3, preferred, auto-left, 1"
        ];
        decoration = {
          blur = {
            size = 0;
          };
        };
        input = {
          kb_layout = "eu";
        };
      };
      extraConfig = ''
        # window resize
        bind = $mod, S, submap, resize

        submap = resize
        binde = , right, resizeactive, 10 0
        binde = , left, resizeactive, -10 0
        binde = , up, resizeactive, 0 -10
        binde = , down, resizeactive, 0 10
        bind = , escape, submap, reset
        submap = reset
      '';
    };
  };
}
