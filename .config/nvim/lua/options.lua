local opt = vim.opt -- wrapper
local o = vim.o     -- global options
local g = vim.g     -- global variables

-------------------------------------- options ------------------------------------------
o.laststatus = 3   -- show single status line
o.showmode = false --don't show insert, normal, etc in command area
-- o.modifiable = false

o.clipboard = "unnamedplus" -- use system clipboard

-- highlight line number of cursor line
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
-- use space instead of tabs, 2 spaces, automatic Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " } -- remove empty lines at end of buffer

-- case sensitive search unless uppercase letters are uses
o.ignorecase = true
o.smartcase = true

-- enable mouse in all modes
o.mouse = "a"

-- Numbers
o.number = true   -- enable line number
o.numberwidth = 2 -- set colume width for numbers to 2
o.ruler = false   -- disable ruler (shows cursor position in command area)
o.relativenumber = true

-- disable nvim intro
opt.shortmess:append "sI" -- skip neovim intro message

o.signcolumn = "yes"      -- always show sign colum
o.splitbelow = true       -- new horizontal splits go below, vertical splits go to right
o.splitright = true
o.timeoutlen = 400        -- key sequence timeout
o.undofile = true         -- persistent undo history

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers - disables builtin language providers to reduce startup time if not used
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
-- detects if running on windows and construct the path, ensure tools like mason are found by lsp and dap client
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH


-- set lsp log level
vim.lsp.set_log_level("off") -- "trace", "debug", "info", "warn", "error", "off"
