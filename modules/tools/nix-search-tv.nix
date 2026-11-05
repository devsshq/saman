{
  flake.modules.homeManager.nix-search-tv = { pkgs, ... }: {
    home.packages = with pkgs; [ nix-search-tv fzf ];

    programs.zsh.initContent = ''
      # nsh: fuzzy-pick nixpkgs packages (Tab = multiselect)
      #   nsh            open a temporary shell with the picks
      #   nsh -p|--print print the picked package names, one per line
      nsh() {
        local print_only=0
        [[ "$1" == -p || "$1" == --print ]] && print_only=1
        local -a pkgs
        pkgs=("''${(@f)$(nix-search-tv print --indexes nixpkgs \
          | fzf -m --preview 'nix-search-tv preview --indexes nixpkgs {}')}")
        [[ -n "''${pkgs[1]}" ]] || return
        if (( print_only )); then
          print -l -- "''${pkgs[@]}"
        else
          nix shell "''${(@)pkgs/#/nixpkgs#}"
        fi
      }
    '';
  };
}
