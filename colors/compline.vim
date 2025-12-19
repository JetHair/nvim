" Name: compline.vim

set background=dark
hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'compline'

let s:bg        = "#000000"
let s:bg_alt    = "#22262b"
let s:base0     = "#0f1114"
let s:base1     = "#171a1e"
let s:base2     = "#1f2228"
let s:base3     = "#282c34"
let s:base4     = "#31313A"
let s:base5     = "#515761"
let s:base6     = "#676d77"
let s:base7     = "#8b919a"
let s:base8     = "#e0dcd4"
let s:fg        = "#f0efeb"
let s:fg_alt    = "#ccc4b4"

let s:red       = "#CDACAC"
let s:orange    = "#ccc4b4"
let s:green     = "#b8c4b8"
let s:teal      = "#b4c4bc"
let s:yellow    = "#d4ccb4"
let s:blue      = "#b4bcc4"
let s:dark_cyan = "#98a4ac"
let s:cyan      = "#b4c0c8"

function! s:hi(group, guifg, guibg, gui, cterm)
    let cmd = "hi " . a:group
    if a:guifg != ""
        let cmd .= " guifg=" . a:guifg
    endif
    if a:guibg != ""
        let cmd .= " guibg=" . a:guibg
    endif
    if a:gui != ""
        let cmd .= " gui=" . a:gui
    endif
    if a:cterm != ""
        let cmd .= " cterm=" . a:cterm
    endif
    exec cmd
endfunction

" Core
call s:hi("Normal",       s:fg,      s:bg,       "NONE", "NONE")
call s:hi("Visual",       "",        s:base4,    "NONE", "NONE")
call s:hi("CursorLine",   "",        s:base1,    "NONE", "NONE")
call s:hi("CursorColumn", "",        s:base1,    "NONE", "NONE")
call s:hi("ColorColumn",  "",        s:base1,    "NONE", "NONE")
call s:hi("LineNr",       s:base4,   "",         "NONE", "NONE")
call s:hi("CursorLineNr", s:fg,      "",         "NONE", "NONE")
call s:hi("SignColumn",   "",        s:bg,       "NONE", "NONE")
call s:hi("Folded",       s:blue,    s:base2,    "NONE", "NONE")
call s:hi("FoldColumn",   s:base5,   s:bg,       "NONE", "NONE")
call s:hi("VertSplit",    s:base0,   "",         "NONE", "NONE")

" UI
call s:hi("StatusLine",   s:fg,      s:base1,    "NONE", "NONE")
call s:hi("StatusLineNC", s:base5,   s:base1,    "NONE", "NONE")
call s:hi("Pmenu",        s:fg,      s:base2,    "NONE", "NONE")
call s:hi("PmenuSel",     s:bg,      s:blue,     "bold", "bold")
call s:hi("Search",       s:bg,      s:yellow,   "bold", "bold")
call s:hi("IncSearch",    s:bg,      s:yellow,   "bold", "bold")
call s:hi("MatchParen",   "",        s:base3,    "bold,underline", "bold,underline")

" Syntax (mirroring doom-compline mappings)
call s:hi("Comment",        s:base4, "", "italic", "italic")
call s:hi("Constant",       s:base7, "", "NONE",   "NONE")
call s:hi("String",         s:green, "", "NONE",   "NONE")
call s:hi("Character",      s:green, "", "NONE",   "NONE")
call s:hi("Number",         s:red,   "", "NONE",   "NONE")
call s:hi("Boolean",        s:red,   "", "NONE",   "NONE")
call s:hi("Float",          s:red,   "", "NONE",   "NONE")
call s:hi("Identifier",     s:base8, "", "NONE",   "NONE")
call s:hi("Function",       s:cyan,  "", "NONE",   "NONE")
call s:hi("Statement",      s:base8, "", "NONE",   "NONE")
call s:hi("Conditional",    s:red,   "", "NONE",   "NONE")
call s:hi("Repeat",         s:red,   "", "NONE",   "NONE")
call s:hi("Label",          s:yellow,"", "NONE",   "NONE")
call s:hi("Operator",       s:base6, "", "NONE",   "NONE")
call s:hi("Keyword",        s:base8, "", "NONE",   "NONE")
call s:hi("PreProc",        s:base8, "", "NONE",   "NONE")
call s:hi("Include",        s:base8, "", "NONE",   "NONE")
call s:hi("Type",           s:blue,  "", "NONE",   "NONE")
call s:hi("StorageClass",   s:yellow,"", "NONE",   "NONE")
call s:hi("Structure",      s:yellow,"", "NONE",   "NONE")
call s:hi("Typedef",        s:yellow,"", "NONE",   "NONE")
call s:hi("Special",        s:cyan,  "", "NONE",   "NONE")
call s:hi("Underlined",     "",      "",         "underline", "underline")
call s:hi("Error",          s:red,   "",         "bold", "bold")
call s:hi("Todo",           s:bg,    s:red,      "bold", "bold")

" Diff
call s:hi("DiffAdd",      s:bg, s:green,  "NONE", "NONE")
call s:hi("DiffChange",   s:bg, s:yellow, "NONE", "NONE")
call s:hi("DiffDelete",   s:bg, s:red,    "NONE", "NONE")
call s:hi("DiffText",     s:bg, s:blue,   "NONE", "NONE")

" Links
hi link Directory       Type
hi link Title           Normal
hi link WarningMsg      yellow
hi link ErrorMsg        Error

" Terminal colors (optional, for better plugin compatibility)
let g:terminal_ansi_colors = [
    \ s:base0, s:red, s:green, s:yellow,
    \ s:blue, s:base8, s:cyan, s:fg,
    \ s:base4, s:red, s:green, s:yellow,
    \ s:blue, s:base8, s:cyan, s:fg_alt
\ ]
