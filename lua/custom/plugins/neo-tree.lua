return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Explorer (Neo-tree)' },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
      },
    },
  },
}
