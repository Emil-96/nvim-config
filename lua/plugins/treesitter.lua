return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
    			ensure_installed = { 
	    			"lua", 
	    			"python", 
	    			"javascript", 
	    			"go", 
	    			"gomod",
	    			"gosum",
	    			"cpp", 
	    			"html", 
	    			"css" 
    			},
    			highlight = { enable = true },
    			indent = { enable = true }
		})
	end,
}

