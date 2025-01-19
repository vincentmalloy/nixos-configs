{
  osConfig,
  config,
  ...
}: {
  programs.helix = {
    enable = true;
    # defaultEditor = true;
    settings = {
      keys = {
        normal = {
          space = {
            # format markdown table
            t = "@mips\\|<ret>&,jxs\\ <ret>r-,";
          };
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
}
