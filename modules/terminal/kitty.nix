{ config, ... }:
let
  c = config.meta.colors;
in
{
  flake.modules.homeManager.kitty = {
    stylix.targets.kitty.enable = false;

    programs.kitty = {
      enable = true;
      font = { name = "Maple Mono NF"; size = 11; };

      settings = {
        foreground = c.fg;
        background = c.bg;
        selection_foreground = c.fg;
        selection_background = c.accentDim;
        cursor = c.accent;
        cursor_text_color = c.bg;
        url_color = c.info;

        active_border_color = c.accent;
        inactive_border_color = c.line;
        bell_border_color = c.warning;

        active_tab_foreground = c.fg;
        active_tab_background = c.accentDim;
        inactive_tab_foreground = c.muted;
        inactive_tab_background = c.bg;
        tab_bar_background = c.bg;

        mark1_foreground = c.bg;
        mark1_background = c.accent;
        mark2_foreground = c.bg;
        mark2_background = c.accentBright;
        mark3_foreground = c.bg;
        mark3_background = c.info;

        color0 = c.line;
        color1 = c.error;
        color2 = c.success;
        color3 = c.warning;
        color4 = c.info;
        color5 = c.accent;
        color6 = c.cyan;
        color7 = c.fgDim;
        color8 = c.muted;
        color9 = c.errorBright;
        color10 = c.successBright;
        color11 = c.warningBright;
        color12 = c.infoBright;
        color13 = c.accentBright;
        color14 = c.cyanBright;
        color15 = c.fg;
      };
    };
  };
}
