return {
  -- GitHub Copilot
  { 'github/copilot.vim' },

  -- Copilot Chat for AI-assisted commit messages and code discussions
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      -- See Configuration section for options
    },
  },
}
