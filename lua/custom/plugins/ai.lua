return {
  -- GitHub Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
    },
    keys = {
      { '<leader>ct', '<cmd>Copilot toggle<CR>', desc = 'Copilot [T]oggle' },
    },
  },
}
