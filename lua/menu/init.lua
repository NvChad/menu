local M = {}
local api = vim.api
local state = require "menu.state"
local layout = require "menu.layout"
local ns = api.nvim_create_namespace "NvMenu"
local volt = require "volt"
local volt_events = require "volt.events"

M.open = function(items, opts)
  opts = opts or {}

  if not state.config then
    state.config = opts
  end

  local config = state.config

  local buf = api.nvim_create_buf(false, true)
  state.bufs[buf] = { items = items, item_gap = opts.item_gap or 10 }
  table.insert(state.bufids, buf)

  local h = #items
  local bufv = state.bufs[buf]
  bufv.w = require("menu.utils").get_width(items)
  bufv.w = bufv.w + bufv.item_gap

  vim.bo[buf].filetype = "NvMenu"

  local win_opts = {
    relative = config.mouse and "mouse" or "cursor",
    width = bufv.w,
    height = h,
    row = 1,
    col = 0,
    border = "single",
    style = "minimal",
  }

  if opts.nested then
    win_opts.relative = "win"

    if config.mouse then
      local pos = vim.fn.getmousepos()
      win_opts.win = pos.winid
      win_opts.col = api.nvim_win_get_width(pos.winid) + 2
      win_opts.row = pos.winrow - 2
    else
      win_opts.win = api.nvim_get_current_win()
      win_opts.col = api.nvim_win_get_width(win_opts.win) + 2
      win_opts.row = api.nvim_win_get_cursor(win_opts.win)[1] - 1
    end
  end

  local win = api.nvim_open_win(buf, not config.mouse, win_opts)

  volt.gen_data {
    { buf = buf, ns = ns, layout = layout },
  }

  api.nvim_win_set_hl_ns(win, ns)
  api.nvim_set_hl(ns, "Normal", { link = "ExBlack2Bg" })
  api.nvim_set_hl(ns, "FloatBorder", { link = "ExBlack2Border" })

  volt.run(buf, { h = h, w = bufv.w })
  volt_events.add(buf)

  volt.mappings {
    bufs = vim.tbl_keys(state.bufs),
    after_close = function()
      state.bufs = {}
      state.bufids = {}
    end,
  }

  if not config.mouse then
    require("menu.mappings").general()
    require("menu.mappings").actions(items, buf)
  end

  -- clear menu if clicked outside
  if not state.autocmd and config.mouse then
    api.nvim_create_autocmd("WinEnter", {
      callback = function(args)
        local mousepos = vim.fn.getmousepos()
        local bufid = api.nvim_win_get_buf(mousepos.winid)

        if vim.bo[bufid].ft ~= "NvMenu" then
          require("volt.utils").close {
            bufs = vim.tbl_keys(state.bufs),
            after_close = function()
              state.bufs = {}
              state.bufids = {}
            end,
          }
          api.nvim_del_autocmd(args.id)
        end
      end,
    })
  end
end

return M
