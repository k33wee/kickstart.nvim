return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Explorer (Neo-tree)' },
      { '\\', '<cmd>Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      window = {
        mappings = {
          ['<space>'] = 'none',
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('VimEnter', {
        desc = 'Open Neo-tree when opening a directory',
        group = vim.api.nvim_create_augroup('neotree-auto-open', { clear = true }),
        callback = function(data)
          local directory = vim.fn.isdirectory(data.file) == 1
          if not directory then return end
          vim.cmd.cd(data.file)
          require('neo-tree.command').execute { action = 'show', position = 'left', dir = data.file }
        end,
      })
    end,
  },
}
