{...}: {
  programs.nixvim = {
    plugins.image = {
      enable = true;
      hijackFilePatterns = [
        "*.png"
        "*.jpg"
        "*.jpeg"
        "*.gif"
        "*.webp"
      ];
    };
  };
}
