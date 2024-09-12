return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      numbers = 'ordinal',
      separator_style = 'slant',
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)

    vim.keymap.set({ 'n' }, '<leader>tx', function(n)
      require('mini.bufremove').delete(n, false)
    end, { desc = '[T]ab close' })

    vim.keymap.set({ 'n' }, '<leader>tp', '<Cmd>BufferLineTogglePin<CR>', { desc = '[T]ab next' })

    vim.keymap.set({ 'n' }, '<leader>t[', '<Cmd>BufferLineCyclePrev<CR>', { desc = '[T]ab previous' })
    vim.keymap.set({ 'n' }, '<leader>t]', '<Cmd>BufferLineCycleNext<CR>', { desc = '[T]ab next' })

    vim.keymap.set({ 'n' }, '<leader>[t', '<Cmd>BufferLineCyclePrev<CR>', { desc = '[T]ab previous' })
    vim.keymap.set({ 'n' }, '<leader>]t', '<Cmd>BufferLineCycleNext<CR>', { desc = '[T]ab next' })
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd('BufAdd', {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
