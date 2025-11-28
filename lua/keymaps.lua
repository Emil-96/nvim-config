-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype
		-- Check if formatter.nvim has a formatter for this filetype
		local formatters = require("formatter.config").values.filetype
		if formatters and formatters[ft] then
			-- Use formatter.nvim if configured
			vim.cmd("FormatWrite")
		else
			-- Use Neovim's built-in reindentation
			vim.cmd("normal! gg=G")
		end
	end,
})
