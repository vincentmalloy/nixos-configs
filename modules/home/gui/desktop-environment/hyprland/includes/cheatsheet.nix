{pkgs, ...}: let
  name = "cheatsheet";
  scriptName = name;
  workspaceName = name;

  toggleKey = "H";

  # run before entering workspace
  script = pkgs.writeShellScript scriptName ''
    #!/usr/bin/env zsh
    title=$(hyprctl -j clients | jq -r '.[] | select(.focusHistoryID==1) | .title')
    initial_title=$(hyprctl -j clients | jq -r '.[] | select(.focusHistoryID==1) | .initialTitle')
    echo "no elp for: ''${initial_title} - ''${title}" | nvim +Man!
  '';
in {
  home.packages = with pkgs; [
    jq
  ];

  wayland.windowManager.hyprland = {
    settings = {
      workspace = [
        "special:${workspaceName}, gapsin:0, gapsout:0, on-created-empty: $terminal ${script}"
      ];
      windowrulev2 = [
        "float, onworkspace:special:${workspaceName}"
        "size 50% 90%, onworkspace:special:${workspaceName}"
        "move 45% 5%, onworkspace:special:${workspaceName}"
      ];
      bind = [
        "$mod, ${toggleKey}, togglespecialworkspace, ${workspaceName}"
        "$mod, ${toggleKey}, submap, ${workspaceName}"
      ];
    };
    extraConfig = ''
      submap = ${workspaceName}
      bindnr = , Q, submap, reset
      bind = $mod, ${toggleKey}, sendshortcut, , Q,title:.*-${scriptName}$
      bind = $mod, ${toggleKey}, submap, reset
      submap = reset
    '';
  };
}

