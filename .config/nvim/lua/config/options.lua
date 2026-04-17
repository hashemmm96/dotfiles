-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g     -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                               -- Enable mouse support
opt.clipboard = 'unnamedplus'                 -- Copy/paste to system clipboard
opt.swapfile = false                          -- Don't use swapfile
opt.completeopt = 'menu,menuone,noinsert' -- Autocomplete options (blink.cmp recommended)
opt.modeline = false                          -- Disable modelines

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true        -- Show line number
opt.showmatch = true     -- Highlight matching parenthesis
opt.foldlevel = 99       -- Open all folds by default
opt.splitright = true    -- Vertical split to the right
opt.splitbelow = true    -- Horizontal split to the bottom
opt.ignorecase = true    -- Ignore case letters when search
opt.smartcase = true     -- Ignore lowercase for the whole pattern
opt.linebreak = true     -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3       -- Set global statusline
opt.title = true         -- Show windows title
opt.titlestring = '%{substitute(getcwd(),$HOME,"~","")}'

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true   -- Use spaces instead of tabs
opt.shiftwidth = 4     -- Shift 4 spaces when tab
opt.tabstop = 4        -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true    -- Enable background buffers
opt.history = 100    -- Remember N lines in history
opt.updatetime = 250 -- ms to wait for trigger an event

g.python3_host_prog = vim.fn.expand('~/.nvim-venv/bin/python3')

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable a few built-in plugins that are rarely used
local disabled_built_ins = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'tar',
    'tarPlugin',
    'rrhelper',
    'spellfile_plugin',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
    'tutor',
    'rplugin',
    'synmenu',
    'optwin',
    'compiler',
    'bugreport',
}

for _, plugin in pairs(disabled_built_ins) do
    g['loaded_' .. plugin] = 1
end
