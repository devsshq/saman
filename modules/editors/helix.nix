{
  flake.modules.nixos.helix = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.helix ]; # for root / doas
  };

  flake.modules.homeManager.helix = {
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
    home.sessionVariables.EDITOR = "hx";
  };
}
