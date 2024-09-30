local strw = vim.fn.strwidth
local state = require "menu.state"
local utils = require "menu.utils"

local format_title = function(buf, name, rtxt, hl, actions, title)
  local bufv = state.bufs[buf]

  if name == " separator" then
    return { { " " .. string.rep("─", bufv.w - 2), hl or "LineNr" } }
  end

  local line = {}
  local name_w = strw(name)

  -- centered title
  if title then
    table.insert(line, { string.rep(" ", ((bufv.w - name_w) / 2)), hl or "LineNr" })
    table.insert(line, { name, hl })
  else
    -- add gap between title and rtxt
    table.insert(line, { name, hl or "ExLightGrey", actions })
    local gap = bufv.w - (name_w + strw(rtxt))
    table.insert(line, { string.rep(" ", gap), hl, actions })
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
    local hover_id = i .. "menu" .. buf
    local hovered = vim.g.nvmark_hovered == hover_id
    local hl = hovered and "ExBlack3Bg" or item.hl

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
          vim.schedule(function()
            if type(item.cmd) == "string" then
              vim.cmd(item.cmd)
            else
              item.cmd()
            end
          end)
        end)

        if err then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end,
    }

    local mark = format_title(buf, " " .. item.name, (item.rtxt or "") .. " ", hl, actions, item.title)
    table.insert(lines, mark)
  end

  return lines
end
