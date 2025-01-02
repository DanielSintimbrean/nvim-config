return {
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[L]azy[G]it' },
    },
  },
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup {}
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup {}

      vim.keymap.set('x', '<leader>re', ':[R]efactor extract ')
      vim.keymap.set('x', '<leader>rf', ':[R]efactor extract_to_file ')

      vim.keymap.set('x', '<leader>rv', ':[R]efactor extract_var ')

      vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':[R]efactor inline_var')

      vim.keymap.set('n', '<leader>rI', ':[R]efactor inline_func')

      vim.keymap.set('n', '<leader>rb', ':[R]efactor extract_block')
      vim.keymap.set('n', '<leader>rbf', ':[R]efactor extract_block_to_file')
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sr',
        function()
          local grug = require 'grug-far'
          grug.open {
            transient = true,
            prefills = {
              paths = vim.fn.expand '%',
            },
          }
        end,
        mode = { 'n', 'v' },
        desc = '[S]earch and [R]eplace',
      },
      {
        '<leader>sR',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n', 'v' },
        desc = '[S]earch and [R]eplace',
      },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          '<leader>Hf',
          function()
            require('harpoon'):list():add()
          end,
          desc = 'Harpoon File',
        },
        {
          '<leader>Hm',
          function()
            local harpoon = require 'harpoon'
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = 'Harpoon Quick Menu',
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          '<leader>' .. i,
          function()
            require('harpoon'):list():select(i)
          end,
          desc = 'Harpoon to File ' .. i,
        })
      end
      return keys
    end,
  },
}
