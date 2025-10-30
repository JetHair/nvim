vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.hlsearch = true
vim.o.scrolloff = 10
vim.o.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.undofile = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.winborder = "single"

-- plugin install
vim.pack.add({
    { name = "catppuccin",           src = "https://github.com/catppuccin/nvim" },
    { name = "mini.pairs",           src = "https://github.com/echasnovski/mini.pairs" },
    { name = "undotree",             src = "https://github.com/jiaoshijie/undotree" },
    { name = "snacks",               src = "https://github.com/folke/snacks.nvim" },
    { name = "render-markdown.nvim", src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { name = "nvim-treesitter",      src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

-- asthetics
require("catppuccin").setup {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    color_overrides = {
        mocha        = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
        },
        integrations = {
            mini = {
                enabled = true,
            },
            nvimtree = true,
            snacks = {
                enabled = true,
                indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
            },
            render_markdown = true,
        }
    }
}
vim.cmd("colorscheme catppuccin")
vim.cmd(":hi statusline guibg=NONE")

--lsp config
vim.lsp.enable({ "lua_ls", "pylsp", "ruff", "ts_ls", "gopls", "nixd", "jsonls", "cssls", "html", "clangd", "yamlls" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.api.nvim_create_user_command('DiagnosticsToggleVirtualText', function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
end, {})
vim.keymap.set('n', '<Leader>ld', ':DiagnosticsToggleVirtualText<CR>', { noremap = true, silent = true })

--  omnicomplete
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

-- system clipboard remap
vim.keymap.set({ "v", "x", "n" }, '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "x" }, '<leader>Y', '"+yy', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true })

-- mini setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('mini.files').setup()
require('mini.files').setup({
    options = {
        use_as_default_explorer = true,
    }
})
vim.keymap.set('n', '<leader>.', function()
    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end)
require('mini.pairs').setup({})

-- snacks setup
require('snacks').setup({
    picker = { enabled = true },
})
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end,
    { noremap = true, silent = true, desc = "Grep Live" })
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end,
    { noremap = true, silent = true, desc = "Find Files" })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end,
    { noremap = true, silent = true, desc = "Help Tags" })
vim.keymap.set('n', '<leader><leader>', function() Snacks.picker.buffers() end,
    { noremap = true, silent = true, desc = "Buffers" })

-- other keymap
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
