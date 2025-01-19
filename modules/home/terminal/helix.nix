{
  pkgs,
  lib,
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
    languages = {
      language-server = {
        nixd = {
          command = lib.getExe pkgs.nixd;
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.alejandra;
          language-servers = [
            "nixd"
          ];
        }
      ];
    };
  };
}
