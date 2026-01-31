vim.api.nvim_create_autocmd("FileType", {
    pattern = "haskell",
    callback = function()
        vim.lsp.start({
            name = 'hls',
            cmd = { 'haskell-language-server-wrapper', '--lsp' },
            root_dir = vim.fs.dirname(vim.fs.find({ '*.cabal' }, { upward = true })[1])
        })
    end,
})
