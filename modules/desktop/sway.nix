{
  flake.modules.nixos.sway = {
    programs.sway.enable = true;
  };

  flake.modules.homeManager.sway = { lib, ... }: {
    wayland.windowManager.sway = {
      enable = true;
      package = null; # provided by programs.sway
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
}
