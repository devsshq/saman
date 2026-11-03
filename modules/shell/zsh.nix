{
  flake.modules.nixos.zsh = {
    programs.zsh.enable = true;
  };

  flake.modules.homeManager.zsh = {
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
      };
      historySubstringSearch = {
        enable = true;
        searchUpKey = [ "^[[A" ];
        searchDownKey = [ "^[[B" ];
      };
    };
  };
}
