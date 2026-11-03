{ lib, pkgs, ... }:
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
        shellAliases = {
          grep = "rg";
          ls = "lsd";
          l = "lsd -ahl";
          lsa = "lsd -ahl";
          vi = "hx";
          vim = "hx";
          vis = "hx";
        };
        history = {
          size = 10000;
          save = 10000;
          share = true;
          # path = "${config.xdg.dataHome}/zsh/history";
        };
        historySubstringSearch = {
          enable = true;
          searchUpKey = [ "^[[A" ];
          searchDownKey = [ "^[[B" ];
        };
      };

      programs.zoxide = { enable = true; options = [ "--cmd" "cd" ]; };
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };
      programs.pay-respects.enable = true;

      home.sessionVariables.EDITOR = "hx";
      home.packages = with pkgs; [ ripgrep lsd helix ];

      

      # programs.git.enable = true;
      # programs.git.config = {
      #   user.name = "devsshq";
      #   user.email = "devssh@tuta.io";
      #   init.defaultBranch = "main";
      #   url."https://github.com/".insteadOf = [ "gh:" "github:" ];
      # };

      programs.kitty = {
        enable = true;
        # font = {
        #   name = "Maple Mono NF";
        #   size = 11;
        # };
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

        output."Virtual-1".resolution = "1920x1080";

      # Stylix uses base03 (muted) for unfocused borders; Arghavan wants line #2B2B2B
        colors =
          let line = lib.mkForce "#2B2B2B";
          in {
            unfocused = { border = line; childBorder = line; };
            focusedInactive = { border = line; childBorder = line; };
          };
          # fonts = { names = [ "Maple Mono NF" ]; size = 10.0; };
        };
      };
    };
  };
}
