{pkgs, ...}: {
  programs.nixvim = {
    globals.transparent_enabled = true;
    extraPlugins = with pkgs.vimPlugins; [
      transparent-nvim
    ];
  };
}
