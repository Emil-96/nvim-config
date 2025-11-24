local cmp_caps = require("cmp_nvim_lsp").default_capabilities()
local servers = require("lsp.servers")

-- Create an autocommand to start LSP when opening files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local bufnr = args.buf
        local filetype = vim.bo[bufnr].filetype
        
        -- Map filetype to LSP server name
        local ft_to_lsp = {
            javascript = "ts_ls",
            typescript = "ts_ls",
            python = "pyright",
            c = "clangd",
            cpp = "clangd",
            go = "gopls",
        }
        
        local server_name = ft_to_lsp[filetype]
        if not server_name or not servers[server_name] then
            return
        end
        
        local default = vim.lsp.config[server_name]
        if not default then
            vim.notify("Unknown server: " .. server_name, vim.log.levels.ERROR)
            return
        end
        
        local final_config = vim.tbl_deep_extend("force", default, servers[server_name] or {}, {
            capabilities = cmp_caps,
        })
        
        vim.lsp.start(final_config, { bufnr = bufnr })
    end,
})