vim.cmd('set background=dark')
vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
end
vim.g.colors_name = 'compline'

local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Color palette
local c = {
    bg        = "#000000",
    bg_alt    = "#22262b",
    base0     = "#0f1114",
    base1     = "#171a1e",
    base2     = "#1f2228",
    base3     = "#282c34",
    base4     = "#31313A",
    base5     = "#515761",
    base6     = "#676d77",
    base7     = "#8b919a",
    base8     = "#e0dcd4",
    fg        = "#f0efeb",
    fg_alt    = "#ccc4b4",

    red       = "#CDACAC",
    orange    = "#ccc4b4",
    green     = "#b8c4b8",
    teal      = "#b4c4bc",
    yellow    = "#d4ccb4",
    blue      = "#b4bcc4",
    dark_cyan = "#98a4ac",
    cyan      = "#b4c0c8",
}

-- Core
hi("Normal", { fg = c.fg, bg = c.bg })
hi("Visual", { bg = c.base1 })
hi("CursorLine", { bg = c.base1 })
hi("CursorColumn", { bg = c.base1 })
hi("ColorColumn", { bg = c.base1 })
hi("LineNr", { fg = c.base4 })
hi("CursorLineNr", { fg = c.fg })
hi("SignColumn", { bg = c.bg })
hi("Folded", { fg = c.blue, bg = c.base2 })
hi("FoldColumn", { fg = c.base5, bg = c.bg })
hi("VertSplit", { fg = c.base0 })

-- UI
hi("StatusLine", { fg = c.fg, bg = c.base1 })
hi("StatusLineNC", { fg = c.base5, bg = c.base1 })
hi("Pmenu", { fg = c.fg, bg = c.base2 })
hi("PmenuSel", { fg = c.bg, bg = c.blue, bold = true })
hi("Search", { fg = c.bg, bg = c.yellow, bold = true })
hi("IncSearch", { fg = c.bg, bg = c.yellow, bold = true })
hi("MatchParen", { bg = c.base3, bold = true, underline = true })

-- Syntax
hi("Comment", { fg = c.base4, italic = true })
hi("Constant", { fg = c.base7 })
hi("String", { fg = c.green })
hi("Character", { fg = c.green })
hi("Number", { fg = c.red })
hi("Boolean", { fg = c.red })
hi("Float", { fg = c.red })
hi("Identifier", { fg = c.base8 })
hi("Function", { fg = c.cyan })
hi("Statement", { fg = c.base8 })
hi("Conditional", { fg = c.red })
hi("Repeat", { fg = c.red })
hi("Label", { fg = c.yellow })
hi("Operator", { fg = c.base6 })
hi("Keyword", { fg = c.base8 })
hi("PreProc", { fg = c.base8 })
hi("Include", { fg = c.base8 })
hi("Type", { fg = c.blue })
hi("StorageClass", { fg = c.yellow })
hi("Structure", { fg = c.yellow })
hi("Typedef", { fg = c.yellow })
hi("Special", { fg = c.cyan })
hi("Underlined", { underline = true })
hi("Error", { fg = c.red, bold = true })
hi("Todo", { fg = c.bg, bg = c.red, bold = true })

-- Diff
hi("DiffAdd", { bg = c.green })
hi("DiffChange", { bg = c.yellow })
hi("DiffDelete", { bg = c.red })
hi("DiffText", { bg = c.blue })

-- Links
hi("Directory", { link = "Type" })
hi("Title", { link = "Normal" })
hi("WarningMsg", { link = "yellow" }) -- Note: this links to the color name; consider using a proper group
hi("ErrorMsg", { link = "Error" })

-- Terminal colors (optional)
vim.g.terminal_ansi_colors = {
    c.base0, c.red, c.green, c.yellow,
    c.blue, c.base8, c.cyan, c.fg,
    c.base4, c.red, c.green, c.yellow,
    c.blue, c.base8, c.cyan, c.fg_alt,
}
