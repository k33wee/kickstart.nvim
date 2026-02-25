--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Teest shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Open GitHub Copilot CLI inside Neovim
local copilot_term_buf = nil
local copilot_term = nil

local function ensure_copilot_term()
  -- Prefer toggleterm if available
  local ok, terminal_mod = pcall(require, 'toggleterm.terminal')
  if ok and terminal_mod and terminal_mod.Terminal then
    local Terminal = terminal_mod.Terminal
    -- If a terminal instance already exists, ensure buffer ref and open if needed
    if copilot_term then
      if copilot_term.bufnr and vim.api.nvim_buf_is_valid(copilot_term.bufnr) then
        local win = vim.fn.bufwinid(copilot_term.bufnr)
        if win == -1 then copilot_term:toggle() end
        copilot_term_buf = copilot_term.bufnr
        return true
      end
    end

    -- Create a new toggleterm Terminal for the copilot CLI
    copilot_term = Terminal:new {
      cmd = 'copilot',
      hidden = true,
      close_on_exit = false,
      -- Use toggleterm's configured direction (do not override)
      on_open = function(term) copilot_term_buf = term.bufnr end,
    }

    copilot_term:toggle()

    if copilot_term.bufnr and vim.api.nvim_buf_is_valid(copilot_term.bufnr) then
      copilot_term_buf = copilot_term.bufnr
      return true
    end

    -- Try to set bufnr shortly after toggle if not yet available
    vim.defer_fn(function()
      if copilot_term and copilot_term.bufnr and vim.api.nvim_buf_is_valid(copilot_term.bufnr) then copilot_term_buf = copilot_term.bufnr end
    end, 50)

    return true
  end

  -- Fallback to built-in terminal if toggleterm isn't available
  if vim.fn.executable 'copilot' ~= 1 then
    vim.notify('copilot CLI not found in $PATH', vim.log.levels.ERROR)
    return false
  end

  vim.cmd 'botright vsplit'
  vim.api.nvim_win_set_width(0, math.floor(vim.o.columns * 0.3))
  vim.cmd 'terminal copilot'
  copilot_term_buf = vim.api.nvim_get_current_buf()
  return true
end

local function get_visual_line_range()
  local start_row = vim.fn.line 'v'
  local end_row = vim.fn.line '.'
  if start_row == 0 or end_row == 0 then
    local start_pos = vim.fn.getpos "'<"
    local end_pos = vim.fn.getpos "'>"
    start_row, end_row = start_pos[2], end_pos[2]
  end
  if start_row == 0 or end_row == 0 then return nil, nil end
  if start_row > end_row then
    start_row, end_row = end_row, start_row
  end
  return start_row, end_row
end

local function file_line_reference(start_line, end_line)
  local full_path = vim.api.nvim_buf_get_name(0)
  if full_path == '' then return nil end
  local rel_path = vim.fn.fnamemodify(full_path, ':.')
  return string.format('@%s:%d-%d', rel_path, start_line, end_line)
end

vim.keymap.set('n', '<leader>cp', function()
  -- If toggleterm Terminal instance exists, use it to toggle the terminal
  if copilot_term and copilot_term.toggle then
    copilot_term:toggle()
    return
  end

  -- Fallback to previous behavior when using builtin terminal
  if copilot_term_buf and vim.api.nvim_buf_is_valid(copilot_term_buf) then
    local win = vim.fn.bufwinid(copilot_term_buf)
    if win ~= -1 then
      vim.api.nvim_win_close(win, true)
      return
    end
  end

  if not ensure_copilot_term() then return end

  -- If using toggleterm, focus the terminal window
  if copilot_term and copilot_term.bufnr and vim.api.nvim_buf_is_valid(copilot_term.bufnr) then
    local win = vim.fn.bufwinid(copilot_term.bufnr)
    if win ~= -1 then vim.api.nvim_set_current_win(win) end
  end
end, { desc = 'Copilot CLI toggle' })

vim.keymap.set('x', '<leader>cp', function()
  local start_line, end_line = get_visual_line_range()
  if not start_line or not end_line then
    vim.notify('No visual selection found', vim.log.levels.WARN)
    return
  end
  local reference = file_line_reference(start_line, end_line)
  if not reference then
    vim.notify('Buffer has no file path', vim.log.levels.WARN)
    return
  end
  if not ensure_copilot_term() then return end

  local buf = copilot_term_buf
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    vim.notify('Copilot terminal buffer is not available', vim.log.levels.ERROR)
    return
  end

  local ok, job_id = pcall(vim.api.nvim_buf_get_var, buf, 'terminal_job_id')
  if not ok or type(job_id) ~= 'number' then
    vim.notify('Copilot terminal is not ready', vim.log.levels.ERROR)
    return
  end
  vim.fn.chansend(job_id, reference .. '\n')
  local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'nx', false)
end, { desc = 'Copilot CLI with range ref' })

local commit_message_generation_in_progress = false
vim.keymap.set('n', '<leader>cm', function()
  if vim.fn.executable 'copilot' ~= 1 then
    vim.notify('copilot CLI not found in $PATH', vim.log.levels.ERROR)
    return
  end
  if commit_message_generation_in_progress then
    vim.notify('Commit message generation already in progress', vim.log.levels.WARN)
    return
  end

  local prompt = table.concat({
    'You are a conventional commit assistant.',
    'Read the staged diff below carefully and rely on its exact content.',
    '1. Determine the best conventional type (feat, fix, docs, style, refactor, perf, test, build, chore).',
    '2. Write a single subject line in the format "<type>: <summary>" that accurately reflects the actual file changes and behaviors.',
    '3. After the subject, add a blank line and describe two or three key diff highlights as "- <change>", referencing file paths or sections exactly as they appear.',
    '4. Output only the formatted commit subject and bullet list; do not invent unrelated changes.',
  }, '\n')
  commit_message_generation_in_progress = true
  vim.notify('Generating commit message with Copilot CLI...', vim.log.levels.INFO)

  vim.system({ 'git', 'diff', '--staged', '--no-color', '--no-ext-diff' }, { text = true }, function(diff_result)
    vim.schedule(function()
      if diff_result.code ~= 0 then
        commit_message_generation_in_progress = false
        vim.notify('Failed to read staged changes', vim.log.levels.ERROR)
        return
      end

      local staged_diff = vim.trim(diff_result.stdout or '')
      if staged_diff == '' then
        commit_message_generation_in_progress = false
        vim.notify('No staged changes found', vim.log.levels.WARN)
        return
      end

      local full_prompt = table.concat({ prompt, '', 'Staged diff:', staged_diff }, '\n')
      vim.system({ 'copilot', '--model', 'gpt-5-mini', '-p', full_prompt, '--silent', '--allow-all' }, { text = true }, function(result)
        vim.schedule(function()
          commit_message_generation_in_progress = false
          if result.code ~= 0 then
            vim.notify('Failed to generate commit message with Copilot CLI', vim.log.levels.ERROR)
            return
          end

          local message = vim.trim(result.stdout or '')
          if message == '' then
            vim.notify('Copilot CLI returned an empty commit message', vim.log.levels.WARN)
            return
          end

          vim.fn.setreg('+', message)
          vim.fn.setreg('"', message)
          vim.notify('Commit message copied to clipboard', vim.log.levels.INFO)
        end)
      end)
    end)
  end)
end, { desc = 'Copilot [C]ommit [M]essage to clipboard' })

-- ==========================================================
-- Lazy-Loaded ToggleTerm Mappings
-- ==========================================================

-- <leader>tt: Toggles the single floating terminal
vim.keymap.set('n', '<leader>tt', function()
  local ok, terminal_mod = pcall(require, 'toggleterm.terminal')
  if not ok then
    vim.notify('ToggleTerm not found. Run :Lazy to check installation.', vim.log.levels.WARN)
    return
  end

  if not _G.my_float_term then
    _G.my_float_term = terminal_mod.Terminal:new {
      direction = 'float',
      float_opts = { border = 'curved' },
      hidden = true,
      on_open = function(term)
        vim.cmd 'startinsert!'
        -- Close the float easily by pressing 'q' in normal mode
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
    }
  end
  _G.my_float_term:toggle()
end, { desc = 'Toggle floating terminal' })

-- <leader>tn: opens a new terminal in a horizontal split, check if there are other opened terminals and create a new one without replacing the existing one, if pressed again split again and open another terminal, and so on.
vim.keymap.set('n', '<leader>tn', function()
  local ok, terminal_mod = pcall(require, 'toggleterm.terminal')
  if not ok then
    vim.notify('ToggleTerm not found. Run :Lazy to check installation.', vim.log.levels.WARN)
    return
  end

  local Terminal = terminal_mod.Terminal
  local new_term = Terminal:new {
    direction = 'horizontal',
    hidden = true,
    on_open = function(term) vim.cmd 'startinsert!' end,
  }
  new_term:toggle()
end, { desc = 'Open new horizontal terminal' })

-- <leader>tk: kills the current terminal buffer, if the current buffer is a terminal.
--  If the current buffer is not a terminal, it should show a warning message.
vim.keymap.set('n', '<leader>tk', function()
  local buf = vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' and not vim.api.nvim_buf_get_option(buf, 'filetype') == 'toggleterm' then
    vim.notify('Current buffer is not a terminal', vim.log.levels.WARN)
    return
  end
  vim.api.nvim_buf_delete(buf, { force = true })
end, { desc = 'Kill current terminal buffer' })

-- ==========================================================
-- Arrow Key Disabling (Keep these below the terminal logic)
-- ==========================================================
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>') -- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- Plugins live in `lua/plugins/*.lua`
  { import = 'plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
