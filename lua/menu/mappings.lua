local utils = require "menu.utils"
local map = vim.keymap.set
local state = require "menu.state"

return function()
  for _, buf in ipairs(vim.tbl_keys(state.bufs)) do
    map("n", "h", function()
      utils.switch_win(-1)
    end, { buffer = buf })

    map("n", "l", function()
      utils.switch_win(1)
    end, { buffer = buf })
  end
end
