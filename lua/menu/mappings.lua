local utils = require "menu.utils"
local map = vim.keymap.set
local state = require "menu.state"

local M = {}

M.actions = function(items, buf)
  local tb = vim.tbl_filter(function(v)
    return not v.rtxt_type and v.rtxt and v.cmd
  end, items)

  for _, v in ipairs(tb) do
    local action = function()
      require("volt").close()

      if type(v.cmd) == "string" then
        vim.cmd(v.cmd)
      else
        v.cmd()
      end
    end

    map("n", v.rtxt, action, { buffer = buf })
  end
end

M.general = function()
  for _, v in ipairs(vim.tbl_keys(state.bufs)) do
    map("n", "h", function()
      utils.switch_win(-1)
    end, { buffer = v })

    map("n", "l", function()
      utils.switch_win(1)
    end, { buffer = v })
  end
end

return M
