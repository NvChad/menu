local M = {}
local api = vim.api
local strw = vim.fn.strwidth
local win_pos = api.nvim_win_get_position
local state = require "menu.state"

local format_title = function(buf, name, rtxt, hl, actions)
  local bufv = state.bufs[buf]
  local line = {}

  if name == " separator" then
    table.insert(line, { " " .. string.rep("─", bufv.w - 2), "LineNr" })
    return line
  end

  table.insert(line, { name, hl or "ExLightGrey", actions })

  local gap = bufv.w - (strw(name) + strw(rtxt))
  table.insert(line, { string.rep(" ", gap), hl, actions })

  if rtxt then
    table.insert(line, { rtxt, hl or "LineNr", actions })
  end

  return line
end

local get_right_bufs = function()
  local config = state.config
  local cur_win = (config.mouse and vim.fn.getmousepos().winid) or api.nvim_get_current_win()
  local wins = api.nvim_list_wins()

  local nvmenu_bufs = {}
  local cur_win_col = win_pos(cur_win)[2]

  for _, id in ipairs(wins) do
    local bufid = api.nvim_win_get_buf(id)

    if vim.bo[bufid].ft == "NvMenu" and win_pos(id)[2] > cur_win_col then
      table.insert(nvmenu_bufs, bufid)
    end
  end

  return nvmenu_bufs
end

local function toggle_nested_menu(items)
  local right_bufs = get_right_bufs()

  if #right_bufs > 0 then
    require("volt.utils").close {
      bufs = right_bufs,
      close_func = function(buf)
        state.bufs[buf] = nil
      end,
    }
  else
    print('duhh..')
    require("menu").open(items, { nested = true })
  end
end

M.items = function(buf)
  local lines = {}
  local bufv = state.bufs[buf]

  for i, item in ipairs(bufv.items or {}) do
    local hover_id = i .. "menu"
    local hovered = vim.g.nvmark_hovered == hover_id
    local hl = hovered and "PmenuSel" or nil

    local nested_menu = item.items

    if nested_menu then
      item.rtxt = ""
    end

    local actions = {
      hover = { id = hover_id, redraw = "items" },
      click = function()
        if nested_menu then
          toggle_nested_menu(nested_menu)
          return
        end

        api.nvim_buf_call(buf, function()
          api.nvim_feedkeys("q", "x", false)
        end)

        item.cmd()
      end,
    }

    local mark = format_title(buf, " " .. item.name, (item.rtxt or "") .. " ", hl, actions)
    table.insert(lines, mark)
  end

  return lines
end

return M
