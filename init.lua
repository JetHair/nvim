-- Set <space> as the leader key
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
    { name = "undotree",        src = "https://github.com/jiaoshijie/undotree" },
    { name = "smart-splits",    src = "https://github.com/mrjones2014/smart-splits.nvim" },
    { name = "nvim-treesitter", src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.cmd("colorscheme compline")
vim.cmd(":hi statusline guibg=NONE")

local keymap = vim.keymap.set

-- LSP you want to enable by default, all LSP config lives in /lsp directory.
vim.lsp.enable({ "lua_ls", "pylsp", "ruff", "ts_ls", "gopls", "nixd", "jsonls", "cssls", "html", "clangd", "yamlls",
    "tinymist" })

-- Rename the variable under your cursor.
keymap('n', '<leader>lr', vim.lsp.buf.rename, { desc = "[r]ename" })

-- Format the code in the current buffer
keymap('n', '<leader>lf', vim.lsp.buf.format, { desc = "[f]ormat buffer" })

-- Toggle Diagonostics
vim.api.nvim_create_user_command('DiagnosticsToggleVirtualText', function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
end, {})
keymap('n', '<Leader>ld', ':DiagnosticsToggleVirtualText<CR>',
    { noremap = true, silent = true, desc = "[d]iagnostics Toggle" })

-- Complition using nvim builtin Complition engine
-- It does not open automatically. Press <c-l> to invoke.
-- Mappings:
-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
-- <c-l>: Open complition menu
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
keymap('i', '<C-l>', '<C-x><C-o>', { noremap = true, silent = true })
vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy", "noinsert" }

-- <leader>y: Copy selected text to system keyboard
-- <leader>yy: Copy line below curosr to system keyboard
-- <leader>p: Pate form system keyboard
keymap({ "v", "x", "n" }, '<leader>y', '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
keymap({ "n", "v", "x" }, '<leader>Y', '"+yy',
    { noremap = true, silent = true, desc = "Yank current line to system clipboard" })
keymap({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard" })

-- Smart-splits: Move focus/cursor to the split/window in the specified direction
keymap('n', '<M-h>', require('smart-splits').move_cursor_left, { desc = "[M]ove to left split/window" })
keymap('n', '<M-j>', require('smart-splits').move_cursor_down, { desc = "[M]ove to bottom split/window" })
keymap('n', '<M-k>', require('smart-splits').move_cursor_up, { desc = "[M]ove to top split/window" })
keymap('n', '<M-l>', require('smart-splits').move_cursor_right, { desc = "[M]ove to right split/window" })
keymap('n', '<M-\\>', require('smart-splits').move_cursor_previous, { desc = "[M]ove to previous split/window" })

-- Clear highlights on search when pressing <Esc> in normal mode
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Visualize, browse and switch between different undo branches.
keymap('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "[u]ndotree Toggle" })

-- Highlight when yanking (copying) text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
