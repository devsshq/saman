{
  flake.modules.nixos.git = {
    programs.git = {
      enable = true;
      config = {
        user.name = "devsshq";
        user.email = "devssh@tuta.io";
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [ "gh:" "github:" ];
      };
    };
  };
}
