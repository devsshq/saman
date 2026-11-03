{ inputs, lib, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];
  systems = [ "x86_64-linux" ];

  # shared values, read as config.meta.* by other modules
  options.meta = {
    username = lib.mkOption { type = lib.types.str; default = "devssh"; };
    stateVersion = lib.mkOption { type = lib.types.str; default = "26.05"; };
  };
}
