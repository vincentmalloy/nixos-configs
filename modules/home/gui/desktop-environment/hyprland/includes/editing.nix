{
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        # "[workspace special:editing silent tag yaziforhelix]kitty -c yazi"
      ];
      workspace = [
        "special:editing, monitor:$primaryMonitor, gapsin:0, gapsout:0"
        # "special:quakemode, monitor:HDMI-A-1, gapsin:0, gapsout:0"
      ];
      windowrulev2 = [
        # "float, onworkspace:special:editing"
        "monitor $primaryMonitor, onworkspace:special:editing"
        # "size 100% 100%, onworkspace:special:editing"
        # "move 0 0, onworkspace:special:editing"
      ];
      # animation = [
      #   "specialWorkspace, 1, 4, default, slidefadevert -100%"
      # ];
      bind = [
        "$mod SHIFT, E, focusmonitor, $primaryMonitor"
        "$mod SHIFT, E, togglespecialworkspace, editing"
        # "$mod, ESCAPE, submap, quakemode"
      ];
    };
    # extraConfig = ''
    #   submap = quakemode
    #   bind = $mod, F, fullscreen
    #   bind = $mod, V, resizeactive, exact 100% 50%
    #   bind = $mod, V, moveactive, exact 0 0
    #   bind = $mod, ESCAPE, togglespecialworkspace, quakemode
    #   bind = $mod, ESCAPE, submap, reset
    #   submap = reset
    # '';
  };
}
