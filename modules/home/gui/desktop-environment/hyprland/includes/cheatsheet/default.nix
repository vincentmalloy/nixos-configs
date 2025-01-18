{
  pkgs,
  lib,
  ...
}: let
  name = "cheatsheet";
  scriptName = name;
  workspaceName = name;

  toggleKey = "H";

  script-src = builtins.readFile ./cheatsheet.zsh;

  # run before entering workspace
  script = (pkgs.writeShellScript scriptName script-src).overrideAttrs (old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
in {
  home.packages = with pkgs; [
    cowsay
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
