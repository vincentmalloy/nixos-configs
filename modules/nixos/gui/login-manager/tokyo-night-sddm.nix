{
  pkgs,
  config,
  ...
}: let
  stylix = config.stylix;
  lib = config.lib;
  image = config.internal.settings.root + /images/desktop/desktop_left.jpg;
in
  pkgs.stdenv.mkDerivation {
    name = "tokyo-night-sddm";
    version = "320c8e74";
    src = pkgs.fetchFromGitHub {
      owner = "siddrs";
      repo = "tokyo-night-sddm";
      rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
      sha256 = "JRVVzyefqR2L3UrEK2iWyhUKfPMUNUnfRZmwdz05wL0=";
    };
    config = pkgs.writeText "theme.conf.user" ''
      FormPosition="center"
      MainColor="${lib.stylix.colors.withHashtag.base05}"
      AccentColor="${lib.stylix.colors.withHashtag.base07}"
      BackgroundColor="${lib.stylix.colors.withHashtag.base01}"
      Font="${stylix.fonts.monospace.name}"
      Background="Backgrounds/custom.jpg"
      HeaderText=" "
      DateFormat=" "
      RoundCorners="0"
    '';
    # dontBuild = true;
    buildPhase = ''
      buildDir=$PWD/tokyo-night-build
      mkdir $buildDir
      cp -r $src/* $buildDir
      chmod +w $buildDir
      chmod +w "$buildDir"/Backgrounds
      cp ${image} $buildDir/Backgrounds/custom.jpg
      cp $config "$buildDir/theme.conf.user"
    '';
    installPhase =
      # sh
      ''
        mkdir -p $out/share/sddm/themes
        cp -aR $buildDir $out/share/sddm/themes/tokyo-night-sddm
      '';
  }
