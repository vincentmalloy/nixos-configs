{
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      "$primaryMonitor" = "HDMI-A-1";
      # "$terminal" = "kitty";
      # "$browser" = "xkittyfirefox";
      # "$launcher" = "wofi";
      # "$fileManager" = "nautilus";
      "$terminal" = config.internal.modules.gui.terminal.pname;
      "$browser" = config.internal.modules.gui.browser.pname;
      "$launcher" = config.internal.modules.gui.launcher.pname;
      "$fileManager" = config.internal.modules.gui.fileManager.pname;
    };
  };
}
