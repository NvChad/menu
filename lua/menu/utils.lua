local M = {}
local api = vim.api
local fn = vim.fn
local state = require "menu.state"

M.get_width = function(tb)
  local w = 0

  for _, value in ipairs(tb) do
    local label = (value.name or "") .. (value.rtxt or "")
    local strlen = fn.strwidth(label)

    if strlen > w then
      w = strlen
    end
  end

  return w
end

local get_bufi = function(bufnr)
  for i, buf in ipairs(state.bufids) do
    if buf == bufnr then
      return i
    end
  end
end

M.adjacent_bufs = function()
  local config = state.config
  local cur_win = (config.mouse and fn.getmousepos().winid) or api.nvim_get_current_win()
  local cur_buf = api.nvim_win_get_buf(cur_win)
  local nvmenu_bufs = {}

  for i, id in ipairs(state.bufids) do
    if i > get_bufi(cur_buf) then
      table.insert(nvmenu_bufs, id)
    end
  end

  return nvmenu_bufs
end

M.switch_win = function(n)
  local cur_i = get_bufi(api.nvim_get_current_buf())

  if n == -1 and cur_i == 1 then
    cur_i = #state.bufids +1
  elseif n == 1 and cur_i == #state.bufids then
    cur_i = 0
  end

  local buf = state.bufids[cur_i + n]
  api.nvim_set_current_win(fn.bufwinid(buf))
end

return M
