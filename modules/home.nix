{ ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."devssh" = {
      home.stateVersion = "26.05";

      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
      };

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.git.enable = true;

      programs.kitty = {
        enable = true;
        font = {
          name = "Maple Mono NF";
          size = 11;
        };
      };

      programs.helix = {
        enable = true;
        settings.editor = {
          line-number = "relative";
          soft-wrap.enable = true;
        };
        languages.language = [
          { name = "c";    indent = { tab-width = 8; unit = "        "; }; }
          { name = "cpp";  indent = { tab-width = 8; unit = "        "; }; }
          { name = "rust"; indent = { tab-width = 8; unit = "        "; }; }
        ];
      };

      wayland.windowManager.sway = {
        enable = true;
        package = null;
        config = {
          terminal = "kitty";
          modifier = "Mod4";
          gaps.inner = 6;
          window.border = 2;
          floating.border = 2;
          fonts = { names = [ "Maple Mono NF" ]; size = 10.0; };
        };
      };
    };
  };
}
