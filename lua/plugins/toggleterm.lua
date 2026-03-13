-- toggleterm plugin
-- https://github.com/akinsho/toggleterm.nvim

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'vertical' then return math.floor(vim.o.columns * 0.4) end
          if term.direction == 'horizontal' then return 15 end
          return 20
        end,
        open_mapping = [[<c-\\>]],
        shade_terminals = true,
        direction = 'float',
        float_opts = { border = 'curved' },
      }
    end,
  },
}
