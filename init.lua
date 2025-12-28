-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers and relative numberline default
vim.o.number = true
vim.o.relativenumber = true

-- Highlight search
vim.o.hlsearch = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

--Sane indentation
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Set tab spaces to 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Saves undo files
vim.o.undofile = true
vim.o.termguicolors = true

-- Set window border to single. Opts are: bold, double, none, rounded, shadow, single, solid
vim.o.winborder = "single"

-- Install plugin via vim.pack if not installed via nix
-- NOTE: Need to be nvim version >0.12
vim.pack.add({
    { name = "undotree",             src = "https://github.com/jiaoshijie/undotree" },
    { name = "smart-splits",         src = "https://github.com/mrjones2014/smart-splits.nvim" },
    { name = "snacks",               src = "https://github.com/folke/snacks.nvim" },
    { name = "oil",                  src = "https://github.com/stevearc/oil.nvim" },
    { name = "ultimate-autopair",    src = "https://github.com/altermo/ultimate-autopair.nvim/" },
    { name = "snacks",               src = "https://github.com/folke/snacks.nvim" },
    { name = "render-markdown.nvim", src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { name = "nvim-treesitter",      src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.cmd("colorscheme compline")
vim.cmd(":hi statusline guibg=NONE")

--**What is LSP?**
--
-- LSP is an initialism you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. In our case it is installed using nix.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`
-- LSP you want to enable by default, all LSP config lives in /lsp directory.
vim.lsp.enable({ "lua_ls", "pylsp", "ruff", "ts_ls", "gopls", "nixd", "jsonls", "cssls", "html", "clangd", "yamlls" })

-- Rename the variable under your cursor.
-- Most Language Servers support renaming across files, etc.
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

-- Format the code in the current buffer
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- Toggle Diagonostics
vim.api.nvim_create_user_command('DiagnosticsToggleVirtualText', function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
end, {})
vim.keymap.set('n', '<Leader>ld', ':DiagnosticsToggleVirtualText<CR>', { noremap = true, silent = true })

-- Complition using nvim builtin Complition engine
-- It does not open automatically. Press <c-l> to invoke.
-- Mappings:
-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
-- <c-l>: Open complition menu
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end
    end,
})
vim.keymap.set('i', '<C-l>', '<C-x><C-o>', { noremap = true, silent = true })
vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy", "noinsert" }

-- Mappings:
-- <leader>y: Copy selected text to system keyboard
-- <leader>yy: Copy line below curosr to system keyboard
-- <leader>p: Pate form system keyboard
vim.keymap.set({ "v", "x", "n" }, '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "x" }, '<leader>Y', '"+yy', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true })

vim.keymap.set('n', '<M-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<M-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<M-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<M-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<M-\\>', require('smart-splits').move_cursor_previous)


-- Oil is a Neovim plugin to browse the file system
-- You can edit your filesystem like a buffer and perform cross-directory actions.
-- You can edit the file system like any nvim buffer.
-- Mappings:
-- <leader>.: Open Oil
--
-- For more see `:help Oil`
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("oil").setup({
    default_file_explorer = true,
})
vim.keymap.set("n", '<leader>.', "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Auto pair `()`, `{}`, etc
require('ultimate-autopair').setup({})

-- Fuzzy Finder (files, lsp, etc)
-- Snacks.picker is similar to Telescope but more faster and supports image view
require('snacks').setup({
    picker = { enabled = true },
    notifier = {
        enabled = true,
        timeout = 3000,
    },
    image = { enabled = true },
    scope = { enabled = true },
})
local picker = require 'snacks.picker'
vim.keymap.set('n', '<leader>sh', function() picker.help() end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', function() picker.keymaps() end, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', function() picker.files() end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', function() picker.pickers() end, { desc = '[S]earch [S]elect Snacks' })
vim.keymap.set('n', '<leader>sw', function() picker.grep_word() end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', function() picker.grep() end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', function() picker.diagnostics() end, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', function() picker.resume() end, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', function() picker.recent() end, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', function() picker.buffers() end, { desc = '[ ] Find existing buffers' })

-- Fuzzy search in current buffer
vim.keymap.set('n', '<leader>/', function()
    picker.lines()
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>s/', function()
    picker.grep_buffers({ prompt_title = 'Live Grep in Open Buffers' })
end, { desc = '[S]earch [/] in Open Files' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Visualize, browse and switch between different undo branches.
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Highlight when yanking (copying) text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
