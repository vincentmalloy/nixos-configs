{...}: {
  projectRootFile = "flake.nix";
  settings = {
    verbose = 0;
    excludes = [
      "*.lock"
      "Makefile"
      "*.jpg"
    ];
  };
  programs.prettier.enable = true;
  # programs.nixfmt.enable = true;
  programs.alejandra.enable = true;
}
