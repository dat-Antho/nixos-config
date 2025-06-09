{lib, ...}: let
  files = lib.filterAttrs (n: v: v == "regular" && lib.hasSuffix ".nix" n) (builtins.readDir ./.);
  modules = lib.mapAttrsToList (name: _: ./. + "/${name}") files;
in {
  imports = builtins.filter (path: baseNameOf path != "default.nix") modules;
}
