vim.pack.add({
    { name = "mini-nvim", src = "https://github.com/nvim-mini/mini.nvim" },
})
local keymap = vim.keymap.set

require("mini.clue").setup({
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        { mode = "n", keys = "\\" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },

    clues = {
        { mode = "n", keys = "<Leader>f", desc = " Find" },
        { mode = "n", keys = "<Leader>l", desc = "󰘦 LSP" },
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),
        require("mini.clue").gen_clues.z(),
    },
    window = {
        delay = 300,
    },
})

-- For more see `:help MiniFiles`
require("mini.files").setup({
    windows = {
        preview = true,
        width_preview = 80,
    },
})
keymap("n", "<leader>.", function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        if buffer_name == "" or string.match(buffer_name, "Starter") then
            require('mini.files').open(vim.loop.cwd())
        else
            require('mini.files').open(vim.api.nvim_buf_get_name(0))
        end
    end,
    { desc = 'Open Files' })

-- Auto pair `()`, `{}`, etc
require("mini.pairs").setup()

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
    highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

local win_config = function()
    local height = math.floor(0.618 * vim.o.lines)
    local width = math.floor(0.4 * vim.o.columns)
    return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
    }
end
require("mini.extra").setup()
require("mini.pick").setup({
    mappings = {
        choose_in_vsplit = "<C-V>",
    },
    options = {
        use_cache = true,
    },
    window = {
        config = win_config,
    },
})
vim.ui.select = MiniPick.ui_select
local pick = require('mini.pick')
local picker = require('mini.extra').pickers.
keymap("n", "<leader>fh", function() pick.builtin.help() end,
    { desc = '[F]ind [h]elp' })
keymap("n", "<leader>ff", function() pick.builtin.files() end,
    { desc = '[F]ind [f]ile' })
keymap("n", "<leader>fw", function()
        local wrd = vim.fn.expand("<cword>")
        pick.builtin.grep({ pattern = wrd })
    end,
    { desc = '[F]ind [w]ord' })
keymap("n", "<leader>fg", function() pick.builtin.grep_live() end,
    { desc = '[F]ind by [g]rep' })
keymap("n", "<leader><space>", function() pick.builtin.buffers() end,
    { desc = '[F]ind []Buffer' })
keymap("n", "<leader>fH", function() picker.hl_groups() end,
    { desc = '[F]ind [H]L Groups' })
keymap("n", "<leader>fd", function() picker.diagnostic() end,
    { desc = '[F]ind [d]iagnostics' })
