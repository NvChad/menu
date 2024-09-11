local M = {}

M.get_width = function(tb)
  local w = 0

  for _, value in ipairs(tb) do
    local label = (value.name or "") .. (value.rtxt or "")
    local strlen = vim.fn.strwidth(label)

    if strlen > w then
      w = strlen
    end
  end

  return w
end

return M
