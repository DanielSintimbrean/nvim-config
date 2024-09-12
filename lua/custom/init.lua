-- Hyprlang LSP
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.hl', 'hypr*.conf' },
  callback = function(event)
    print(string.format('starting hyprls for %s', vim.inspect(event)))
    vim.lsp.start {
      name = 'hyprlang',
      cmd = { 'hyprls' },
      root_dir = vim.fn.getcwd(),
    }
  end,
})

vim.g.maplocalleader = ','

-- My personal keybinds
vim.keymap.set('n', '<leader>sc', "<cmd>lua require('fzf-lua').command_history()<CR>", { noremap = true, silent = true, desc = '[S]earch [C]ommand history' })

vim.keymap.set('n', '<C-s>', [[:%s/\<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[Search] and replace all occurrences of the current word' })


---- Select and replace all occurrences
vim.keymap.set('v', '<C-s>', [["hy:%s/<C-r>h/<C-r>h/gI<Left><Left><Left>]], { desc = '[Search] and replace all occurrences from selected in V mode' })

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines one line DOWN [k]', silent = true })
---- Move line up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines one line UP [j]', silent = true })

--- Preserve the 0 register when pasting
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Pasting without losing the what is the yank buffer' })

--- Disable Q key
vim.keymap.set('n', 'Q', '<nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'q:', '<nop>', { noremap = true, silent = true })

vim.keymap.set('n', 'J', 'mzJ`z')

--- Keep the cursor in the center when navigating
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
    and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end
