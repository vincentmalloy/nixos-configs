{lib, ...}: {
  options.programs.glow = lib.mkOption {
    type = lib.types.Submodule {
      options = {
      };
    };
  };
}
