return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
    			view = { width = 30 },
			renderer = { icons = { show = { git = true } } },
		})
	end,
}

