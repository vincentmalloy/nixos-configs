{...}: {
  programs.nixvim = {
    opts = {
      # show line numbers
      number = true;

      # enter digraphs with {char1} <BS> {char2}
      digraph = false;

      # tab width
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;

      # use spaces instead of tabs
      expandtab = true;

      breakindent = true;

      cursorcolumn = false;
      cursorline = true;

      # Hide command line unless needed
      cmdheight = 0;
    };
  };
}
