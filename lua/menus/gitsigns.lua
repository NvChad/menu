return {

  {
    name = "  Gitsigns",
    hl = "Exblue",
    title=true,
  },

  { name = "separator", hl='Exblue' },

  {
    name = "Stage Hunk",
    cmd = "Gitsigns stage_hunk",
    rtxt = "<leader>hs",
  },
  {
    name = "Reset Hunk",
    cmd = "Gitsigns reset_hunk",
    rtxt = "<leader>hr",
  },

  {
    name = "Stage Buffer",
    cmd = "Gitsigns stage_buffer",
    rtxt = "<leader>hS",
  },
  {
    name = "Undo Stage Hunk",
    cmd = "Gitsigns undo_stage_hunk",
    rtxt = "<leader>hu",
  },
  {
    name = "Reset Buffer",
    cmd = "Gitsigns reset_buffer",
    rtxt = "<leader>hR",
  },
  {
    name = "Preview Hunk",
    cmd = "Gitsigns preview_hunk",
    rtxt = "<leader>hp",
  },

  { name = "separator" },

  {
    name = "Blame Line",
    cmd = 'lua require"gitsigns".blame_line{full=true}',
    rtxt = "<leader>hb",
  },
  {
    name = "Toggle Current Line Blame",
    cmd = "Gitsigns toggle_current_line_blame",
    rtxt = "<leader>tb",
  },

  { name = "separator" },

  {
    name = "Diff This",
    cmd = "Gitsigns diffthis",
    rtxt = "<leader>hd",
  },
  {
    name = "Diff Last Commit",
    cmd = 'lua require"gitsigns".diffthis("~")',
    rtxt = "<leader>hD",
  },
  {
    name = "Toggle Deleted",
    cmd = "Gitsigns toggle_deleted",
    rtxt = "<leader>td",
  },
}
