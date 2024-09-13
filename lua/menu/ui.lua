local api = vim.api
local strw = vim.fn.strwidth
local state = require "menu.state"
local utils = require "menu.utils"

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

local function toggle_nested_menu(items)
  local right_bufs = utils.adjacent_bufs()

  if #right_bufs > 0 then
    require("volt.utils").close {
      bufs = right_bufs,
      close_func = function(buf)
        state.bufs[buf] = nil

        for i, val in ipairs(state.bufids) do
          if val == buf then
            table.remove(state.bufids, i)
          end
        end
      end,
    }
  else
    require("menu").open(items, { nested = true })
  end
end

return function(buf)
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

        require("volt").close(buf)

        local _, err = pcall(function()
          if type(item.cmd) == "string" then
            vim.cmd(item.cmd)
          else
            item.cmd()
          end
        end)

        if(err) then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end,
    }

    local mark = format_title(buf, " " .. item.name, (item.rtxt or "") .. " ", hl, actions)
    table.insert(lines, mark)
  end

  return lines
end
