{lib, ...}: let
  inherit (lib) concatMapAttrs;
  inherit (builtins) pathExists readFileType readDir elemAt;

  readOptionalFile = path:
    if pathExists path
    then (import path)
    else {};

  defaultSubmodule = submodule:
    concatMapAttrs
    (
      opt: optDef:
        if optDef ? default
        then {${opt} = optDef.default;}
        else {}
    )
    submodule.options;

  defaultSubmoduleAttr = attrsType:
    defaultSubmodule (elemAt attrsType.getSubModules 0);

  # creates an attribute set of { subDirName = <modules>; }
  readModules = dir:
    if pathExists dir && readFileType dir == "directory"
    then
      concatMapAttrs
      (
        entry: type: let
          fileOrDir = "${dir}/${entry}";
          dirDefault = "${dir}/${entry}/default.nix";
        in
          if pathExists fileOrDir
          then
            if readFileType fileOrDir == "regular" || pathExists dirDefault
            then {${entry} = fileOrDir;}
            else {}
          else {}
      )
      (readDir dir)
    else {};

  readConfigurations = dir:
    if pathExists dir && readFileType dir == "directory"
    then
      concatMapAttrs
      (
        entry: type: let
          subDir = "${dir}/${entry}";
          dirDefault = "${dir}/${entry}/configuration.nix";
        in
          if pathExists subDir
          then
            if pathExists dirDefault
            then {${entry} = dirDefault;}
            else {}
          else {}
      )
      (readDir dir)
    else {};
in {
  internal.plumbing.lib = {
    inherit defaultSubmoduleAttr readModules readConfigurations;
  };
}
