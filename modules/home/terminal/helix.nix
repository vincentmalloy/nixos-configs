{
  osConfig,
  config,
  ...
}: {
  # home.sessionVariables = {
    # EDITOR = "hx";
  # };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      keys = {
        normal = {
          "A-t" = "@mips<backspace>|<ret>&,[pjxs<backspace><space>r-,";
        };
      };
      editor = {
        true-color = true;
        bufferline = "multiple";
        cursorline = true;
        rulers = [120];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
      };
    };
  };

  # programs.yazi = {
    # enable = true;
  # };
}
