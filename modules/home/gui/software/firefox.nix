{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.gui.software.firefox;
in {
  options.internal.modules.gui.software.firefox = {
    enable = lib.mkEnableOption "firefox browser settings";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "about:blank";
            "browser.display.use_system_colors" = true;
            "browser.display.background_color.dark" = config.lib.stylix.colors.withHashtag.base00;
          };
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            keepassxc-browser
            feedbroreader
          ];
          bookmarks = [
            {
              name = "Toolbar";
              toolbar = true;
              bookmarks = [
                {
                  name = "Nix";
                  bookmarks = [
                    {
                      name = "homepage";
                      tags = ["nix"];
                      url = "https://nixos.org";
                    }
                    {
                      name = "wiki";
                      tags = ["wiki" "nix"];
                      url = "https://wiki.nixos.org";
                    }
                    {
                      name = "documentation";
                      tags = ["nix" "docs"];
                      url = "https://nix.dev";
                    }
                    {
                      name = "nixpkgs manual";
                      tags = ["nix" "docs"];
                      url = "https://ryantm.github.io/nixpkgs";
                    }
                    {
                      name = "mynixos";
                      tags = ["nix" "nixos"];
                      url = "https://mynixos.com";
                    }
                    {
                      "name" = "learning resources";
                      bookmarks = [
                        {
                          name = "zero to nix";
                          tags = ["nix" "guides"];
                          url = "https://zero-to-nix.com";
                        }
                        {
                          name = "nix pills";
                          tags = ["nix" "guides"];
                          url = "https://nixos.org/guides/nix-pills";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
            {
              name = "Shortcuts";
              bookmarks = [
                {
                  name = "wikipedia search";
                  tags = ["wiki"];
                  keyword = "wiki";
                  url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
                }
                {
                  name = "home manager options search";
                  tags = ["nix" "home-manager"];
                  keyword = "hmo";
                  url = "https://home-manager-options.extranix.com/?query=%s&release=master";
                }
                {
                  name = "nix builtins search";
                  tags = ["nix"];
                  keyword = "nb";
                  url = "https://nix-builtins-search.extranix.com/?query=%s&release=nix-v2.24";
                }
                {
                  name = "subreddit shortcut";
                  tags = ["reddit"];
                  keyword = "r";
                  url = "https://old.reddit.com/r/%s";
                }
                {
                  name = "search reddit with google";
                  tags = ["search" "reddit"];
                  keyword = "sr";
                  url = "https://www.google.com/search?q=%s%20site%3Areddit.com";
                }
              ];
            }
            {
              name = "Bartosz Ciechanowski";
              url = "https://ciechanow.ski/";
            }
          ];
        };
      };
    };
  };
}
