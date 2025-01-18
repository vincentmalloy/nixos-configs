{pkgs, ...}: let
  name = "quakemode";
  scriptName = name;
  workspaceName = name;

  toggleKey = "ESCAPE";

  # run on entering empty workspace
  script = pkgs.writeShellScript scriptName ''
    #!/usr/bin/env zsh

    i=0
    while [ $i -lt 25 ]
    do
      echo ""
      i=$((i+1))
    done
    fastfetch
  '';
in {
  wayland.windowManager.hyprland = {
    settings = {
      workspace = [
        "special:${workspaceName}, monitor:$primaryMonitor, gapsin:0, gapsout:0, on-created-empty:$terminal --hold ${script}"
      ];
      windowrulev2 = [
        "float, onworkspace:special:${workspaceName}"
        "monitor $primaryMonitor, onworkspace:special:${workspaceName}"
        "size 100% 50%, onworkspace:special:${workspaceName}"
        "move 0 0, onworkspace:special:${workspaceName}"
      ];
      animation = [
        "specialWorkspace, 1, 4, default, slidefadevert -100%"
      ];
      bind = [
        "$mod, ${toggleKey}, focusmonitor, $primaryMonitor"
        "$mod, ${toggleKey}, togglespecialworkspace, ${workspaceName}"
        "$mod, ${toggleKey}, submap, ${workspaceName}"
        "$mod SHIFT, ${toggleKey}, movetoworkspace, special:${workspaceName}"
      ];
    };
    extraConfig = ''
      submap = ${workspaceName}
      bind = $mod, F, fullscreen
      bind = $mod, V, resizeactive, exact 100% 50%
      bind = $mod, V, moveactive, exact 0 0
      bind = $mod, ${toggleKey}, togglespecialworkspace, ${workspaceName}
      bind = $mod, ${toggleKey}, submap, reset
      submap = reset
    '';
  };
}
