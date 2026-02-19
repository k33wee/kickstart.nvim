return {
  -- GitHub Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<M-y>',
          next = '<M-n>',
          prev = '<M-p>',
        },
      },
    },
    keys = {
      { '<leader>ce', '<cmd>Copilot enable<CR>', desc = 'Copilot [E]nable' },
      { '<leader>cd', '<cmd>Copilot disable<CR>', desc = 'Copilot [D]isable' },
    },
  },
}
