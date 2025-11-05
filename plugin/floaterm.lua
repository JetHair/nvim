-- Function to create and toggle a floating terminal
local function toggle_floating_terminal()
    -- Configuration for the floating window
    local width = math.floor(vim.o.columns * 0.8)       -- 80% of editor width
    local height = math.floor(vim.o.lines * 0.8)        -- 80% of editor height
    local row = math.floor((vim.o.lines - height) / 2)  -- Center vertically
    local col = math.floor((vim.o.columns - width) / 2) -- Center horizontally

    -- Check if a floating terminal already exists
    local buf = vim.g.floating_terminal_buf
    local win = vim.g.floating_terminal_win

    -- If the window exists and is valid, close it
    if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
        vim.g.floating_terminal_win = nil
        return
    end

    -- If no buffer exists or it's invalid, create a new terminal buffer
    if not buf or not vim.api.nvim_buf_is_valid(buf) then
        buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
        vim.g.floating_terminal_buf = buf
        -- Start terminal in the buffer
        vim.api.nvim_buf_call(buf, function()
            vim.fn.termopen(vim.o.shell)
        end)
        -- Map <Esc><Esc> to close the terminal
        vim.api.nvim_buf_set_keymap(
            buf,
            't',
            '<Esc><Esc>',
            '<C-\\><C-n>:q<CR>',
            { noremap = true, silent = true }
        )
    end

    -- Create the floating window
    local win_opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'single',
    }
    win = vim.api.nvim_open_win(buf, true, win_opts)
    vim.g.floating_terminal_win = win

    -- Enter terminal mode automatically
    vim.api.nvim_command('startinsert')
end

-- Keymap to toggle the floating terminal with Alt-w
vim.keymap.set('n', '<A-w>', toggle_floating_terminal, { noremap = true, silent = true })
vim.keymap.set('t', '<A-w>', toggle_floating_terminal, { noremap = true, silent = true })
