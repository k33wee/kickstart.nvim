-- toggleterm plugin
-- https://github.com/akinsho/toggleterm.nvim

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<leader>tt]],
        shade_terminals = true,
        direction = 'float',
        float_opts = { border = 'curved' },
      }
    end,
  },
}
