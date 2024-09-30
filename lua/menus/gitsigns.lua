return {

  {
    name = "Stage Hunk",
    cmd = "Gitsigns stage_hunk",
    rtxt = "sh",
  },
  {
    name = "Reset Hunk",
    cmd = "Gitsigns reset_hunk",
    rtxt = "rh",
  },

  {
    name = "Stage Buffer",
    cmd = "Gitsigns stage_buffer",
    rtxt = "sb",
  },
  {
    name = "Undo Stage Hunk",
    cmd = "Gitsigns undo_stage_hunk",
    rtxt = "us",
  },
  {
    name = "Reset Buffer",
    cmd = "Gitsigns reset_buffer",
    rtxt = "rb",
  },
  {
    name = "Preview Hunk",
    cmd = "Gitsigns preview_hunk",
    rtxt = "hp",
  },

  { name = "separator" },

  {
    name = "Blame Line",
    cmd = 'lua require"gitsigns".blame_line{full=true}',
    rtxt = "b",
  },
  {
    name = "Toggle Current Line Blame",
    cmd = "Gitsigns toggle_current_line_blame",
    rtxt = "tb",
  },

  { name = "separator" },

  {
    name = "Diff This",
    cmd = "Gitsigns diffthis",
    rtxt = "dt",
  },
  {
    name = "Diff Last Commit",
    cmd = 'lua require"gitsigns".diffthis("~")',
    rtxt = "dc",
  },
  {
    name = "Toggle Deleted",
    cmd = "Gitsigns toggle_deleted",
    rtxt = "td",
  },
}
