local M = {}
local api = vim.api
local state = require "menu.state"
local layout = require "menu.layout"
local ns = api.nvim_create_namespace "NvMenu"
local extmarks = require "volt"
local extmarks_events = require "volt.events"

M.open = function(items, opts)
  opts = opts or {}

  local buf = api.nvim_create_buf(false, true)
  state.bufs[buf] = { items = items, item_gap = opts.item_gap or 10 }

  local h = #items
  local bufv = state.bufs[buf]
  bufv.w = require("menu.utils").get_width(items)
  bufv.w = bufv.w + bufv.item_gap

  vim.bo[buf].filetype = "NvMenu"

  local win_opts = {
    relative = "mouse",
    width = bufv.w,
    height = h,
    row = 1,
    col = 0,
    border = "single",
    style = "minimal",
  }

  if opts.nested then
    win_opts.relative = "win"

    local pos = vim.fn.getmousepos()

    win_opts.win = pos.winid
    win_opts.col = api.nvim_win_get_width(pos.winid) + 2
    win_opts.row = pos.winrow - 2
  end

  local win = api.nvim_open_win(buf, true, win_opts)

  extmarks.gen_data {
    { buf = buf, ns = ns, layout = layout },
  }

  api.nvim_win_set_hl_ns(win, ns)
  api.nvim_set_hl(ns, "Normal", { link = "ExBlack2Bg" })
  api.nvim_set_hl(ns, "FloatBorder", { link = "ExBlack2Border" })

  extmarks.run(buf, { h = h, w = bufv.w })
  extmarks_events.add(buf)

  extmarks.mappings {
    bufs = vim.tbl_keys(state.bufs),
    close_func = function(bufid)
      state.bufs[bufid] = nil
    end,
  }

  -- clear menu if clicked outside
  if not state.autocmd then
    api.nvim_create_autocmd("WinEnter", {
      callback = function(args)
        local mousepos = vim.fn.getmousepos()
        local bufid = api.nvim_win_get_buf(mousepos.winid)

        if vim.bo[bufid].ft ~= "NvMenu" then
          require("volt.utils").close {
            bufs = vim.tbl_keys(state.bufs),
            close_func = function(id)
              state.bufs[id] = nil
            end,
          }
          api.nvim_del_autocmd(args.id)
        end
      end,
    })
  end
end

return M
