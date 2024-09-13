local function nvimtree_api(name, func)
  local api = require "nvim-tree.api"
  local node = api.tree.get_node_under_cursor()
  api[name][func](node)
end

return {

  {
    name = "  New file",
    cmd = function()
      nvimtree_api("fs", "create")
    end,
    rtxt = "a",
  },

  {
    name = "󰉋  New folder",
    cmd = function()
      nvimtree_api("fs", "create")
    end,
    rtxt = "a", -- Same key as for creating a new file or directory
  },

  { name = "separator" },

  {
    name = "  Cut",
    cmd = function()
      nvimtree_api("fs", "cut")
    end,
    rtxt = "x",
  },

  {
    name = "  Paste",
    cmd = function()
      nvimtree_api("fs", "paste")
    end,
    rtxt = "p",
  },

  {
    name = "  Copy",
    cmd = function()
      nvimtree_api("copy", "node")
    end,
    rtxt = "c",
  },

  {
    name = "󰴠  Copy absolute path",
    cmd = function()
      nvimtree_api("copy", "absolute_path")
    end,
    rtxt = "gy",
  },

  {
    name = "  Copy relative path",
    cmd = function()
      nvimtree_api("copy", "relative_path")
    end,
    rtxt = "Y",
  },

  { name = "separator" },

  {
    name = "  Rename",
    cmd = function()
      nvimtree_api("fs", "rename")
    end,
    rtxt = "r",
  },

  {
    name = "  Trash",
    cmd = function()
      nvimtree_api("fs", "trash")
    end,
    rtxt = "D",
  },

  {
    name = "  Delete",
    cmd = function()
      nvimtree_api("fs", "remove")
    end,
    rtxt = "d",
  },
}
