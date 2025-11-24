return {
	-- vim-go
	{
		"fatih/vim-go",
		build = ":GoUpdateBinaries",
		config = function()
			vim.g.go_fmt_command = "goimports"
			vim.g.go_def_mapping_enabled = 1
			vim.g.go_doc_keywordprg_enabled = 1
			vim.g.go_highlight_structs = 1
			vim.g.go_highlight_methods = 1
			vim.g.go_highlight_fields = 1
			vim.g.go_highlight_functions = 1
		end,
	},
}
