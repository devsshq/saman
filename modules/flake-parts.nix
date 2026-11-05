{ inputs, lib, config, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];
  config.systems = [ "x86_64-linux" ];

  # shared values, read as config.meta.* by other modules
  options.meta = {
    username = lib.mkOption { type = lib.types.str; default = "devssh"; };
    stateVersion = lib.mkOption { type = lib.types.str; default = "26.05"; };
    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        bg = "#121212";
        surface = "#1B1B1B";
        line = "#2B2B2B";
        muted = "#8C867A";
        fg = "#EDE3BA";
        fgDim = "#C1B998";
        accentBase = "#9011BF";
        accent = "#BE55E6";
        accentBright = "#CA74EA";
        accentDim = "#3A0F4D";
        error = "#D9604C";
        errorBright = "#E07D6C";
        warning = "#D9A441";
        warningBright = "#E0B463";
        success = "#7FAE6B";
        successBright = "#96BD86";
        info = "#6E9BC4";
        infoBright = "#88ADCF";
        cyan = "#6FAFA8";
        cyanBright = "#89BDB8";
      };
    };
  };
}
