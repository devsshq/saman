{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts = {
      packages = with pkgs; [
        maple-mono.NF
        ibm-plex
        liberation_ttf
        noto-fonts
        noto-fonts-color-emoji
        roboto
        dejavu_fonts
      ];
      fontconfig.defaultFonts = {
        monospace = [ "Maple Mono NF" ];
        sansSerif = [ "IBM Plex Sans" "IBM Plex Sans Arabic" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
