{
  lib ? import <nixpkgs/lib>,
  drv-parts ? import ../../../default.nix {inherit lib;},
  ...
}: let
  hello = {
    # select builtins.derivation as a backend for this package
    imports = [drv-parts.modules.drv-parts.builtins-derivation];

    public.name = "test";

    # set options
    builtins-derivation = {
      builder = "/bin/sh";
      args = ["-c" "echo $name > $out"];
      system = builtins.currentSystem;
    };
  };
in
  drv-parts.lib.derivationFromModules {} hello
