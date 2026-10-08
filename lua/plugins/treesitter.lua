return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local treesitter = require("nvim-treesitter")

		local languages = {
			"lua", 
			"python", 
			"javascript", 
			"go", 
			"gomod",
			"gosum",
			"cpp", 
			"html", 
			"css",
			"yaml"
		}

		treesitter.setup()

		treesitter.install(languages)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}

