{ lib, ... }:
{
  imports = (
    builtins.map (f: ./. + "/${f}")
      (builtins.filter (f: f != "default.nix" && lib.hasSuffix ".nix" f)
        (builtins.attrNames (builtins.readDir ./.)))
  );
}
