{ config, ... }:
let
  c = config.meta.colors;
in
{
  flake.modules.homeManager.gitui = {
    stylix.targets.gitui.enable = false;

    programs.gitui = {
      enable = true;
      theme = ''
        (
          selected_tab: Some("${c.accent}"),
          command_fg: Some("${c.fg}"),
          selection_bg: Some("${c.accentDim}"),
          selection_fg: Some("${c.fg}"),
          cmdbar_bg: Some("${c.surface}"),
          cmdbar_extra_lines_bg: Some("${c.surface}"),
          disabled_fg: Some("${c.muted}"),
          diff_line_add: Some("${c.success}"),
          diff_line_delete: Some("${c.error}"),
          diff_file_added: Some("${c.success}"),
          diff_file_removed: Some("${c.error}"),
          diff_file_moved: Some("${c.accent}"),
          diff_file_modified: Some("${c.warning}"),
          commit_hash: Some("${c.accent}"),
          commit_time: Some("${c.cyan}"),
          commit_author: Some("${c.success}"),
          danger_fg: Some("${c.error}"),
          push_gauge_bg: Some("${c.accent}"),
          push_gauge_fg: Some("${c.bg}"),
          tag_fg: Some("${c.warning}"),
          branch_fg: Some("${c.cyan}")
        )
      '';
    };
  };
}
