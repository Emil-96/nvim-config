return {
    "mhartington/formatter.nvim",
    config = function()
	require("formatter").setup({
            filetype = {
                --[[lua = function()
                    return {
                        exe = "stylua",
                        args = { "--search-parent-directories", "--stdin-filepath", vim.api.nvim_buf_get_name(0), "-" },
                    }
                end,--]]
                go = function()
                    return {
                        exe = "goimports",
                    }
                end,
            },
        })
    end,
}
