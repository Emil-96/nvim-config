vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.diagnostic.config({
    virtual_text = true,
    float = {
        border = "rounded",
        source = "always",
    },
})
