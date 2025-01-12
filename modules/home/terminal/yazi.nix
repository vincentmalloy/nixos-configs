{pkgs, ...}: let
  eza-preview = pkgs.fetchFromGitHub {
    owner = "ahkohd";
    repo = "eza-preview.yazi";
    rev = "5ef05bcee141291566276e62cc16e265a387dca4";
    hash = "sha256-L7i+uL2kAx3AUr5EAzRrduoV2m4+/tE1gCfbTOSuAc4=";
  };
  # eza-preview = pkgs.fetchFromGitHub {
  # owner = "sharklasers996";
  # repo = "eza-preview.yazi";
  # rev = "7ca4c2558e17bef98cacf568f10ec065a1e5fb9b";
  # hash = "sha256-ncOOCj53wXPZvaPSoJ5LjaWSzw1omHadKDrXdIb7G5U=";
  # };
  # eza-preview = pkgs.fetchFromGitHub {
  # owner = "ahkohd";
  # repo = "eza-preview.yazi";
  # rev = "7ca4c2558e17bef98cacf568f10ec065a1e5fb9b";
  # hash = "sha256-ncOOCj53wXPZvaPSoJ5LjaWSzw1omHadKDrXdIb7G5U=";
  # };
in {
  programs.yazi = {
    enableZshIntegration = true;
    shellWrapperName = "yy";
    settings = {
      manager = {
        ratio = [1 3 5];
      };
      plugin = {
        prepend_previewers = [
          {
            name = "*/";
            run = "eza-preview";
          }
        ];
      };
    };
    plugins = {
      inherit eza-preview;
    };

    initLua =
      /*
      lua
      */
      ''
        require("eza-preview"):setup()
      '';
  };
}
