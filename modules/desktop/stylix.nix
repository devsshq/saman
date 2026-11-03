{ inputs, ... }:
{
  flake.modules.nixos.stylix = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];

    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = {
        base00 = "121212"; # bg
        base01 = "1B1B1B"; # surface
        base02 = "3A0F4D"; # accent-dim (selection)
        base03 = "8C867A"; # muted
        base04 = "8C867A";
        base05 = "EDE3BA"; # fg
        base06 = "EDE3BA";
        base07 = "EDE3BA";
        base08 = "D9604C"; # error
        base09 = "D9A441";
        base0A = "D9A441"; # warning
        base0B = "7FAE6B"; # success
        base0C = "6FAFA8"; # cyan
        base0D = "BE55E6"; # accent
        base0E = "BE55E6"; # ANSI magenta
        base0F = "6E9BC4"; # info
      };
      image = ../../assets/wall.png;
      fonts = {
        monospace = { package = pkgs.maple-mono.NF; name = "Maple Mono NF"; };
        sansSerif = { package = pkgs.ibm-plex; name = "IBM Plex Sans"; };
        emoji = { package = pkgs.noto-fonts-color-emoji; name = "Noto Color Emoji"; };
      };
    };
  };
}
