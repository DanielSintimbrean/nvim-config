
local M = {}

function M.visual_replace()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  local text = table.concat(lines, "\n")
  text = vim.fn.escape(text, [[/\]])
  vim.cmd(string.format("%%s/%s/%s/gI", text, text))
  vim.api.nvim_input("<Left><Left><Left>")
end

return M
