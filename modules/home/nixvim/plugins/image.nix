{...}: {
  programs.nixvim = {
    plugins.image = {
      enable = true;
      settings.hijack_file_patterns = [
        "*.png"
        "*.jpg"
        "*.jpeg"
        "*.gif"
        "*.webp"
      ];
    };
  };
}
