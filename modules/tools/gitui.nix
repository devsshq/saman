{
  flake.modules.homeManager.gitui = {
    stylix.targets.gitui.enable = false;

    programs.gitui = {
      enable = true;
      theme = ''
        (
          selected_tab: Some("#BE55E6"),
          command_fg: Some("#EDE3BA"),
          selection_bg: Some("#3A0F4D"),
          selection_fg: Some("#EDE3BA"),
          cmdbar_bg: Some("#1B1B1B"),
          cmdbar_extra_lines_bg: Some("#1B1B1B"),
          disabled_fg: Some("#8C867A"),
          diff_line_add: Some("#7FAE6B"),
          diff_line_delete: Some("#D9604C"),
          diff_file_added: Some("#7FAE6B"),
          diff_file_removed: Some("#D9604C"),
          diff_file_moved: Some("#BE55E6"),
          diff_file_modified: Some("#D9A441"),
          commit_hash: Some("#BE55E6"),
          commit_time: Some("#6FAFA8"),
          commit_author: Some("#7FAE6B"),
          danger_fg: Some("#D9604C"),
          push_gauge_bg: Some("#BE55E6"),
          push_gauge_fg: Some("#121212"),
          tag_fg: Some("#D9A441"),
          branch_fg: Some("#6FAFA8")
        )
      '';
    };
  };
}
