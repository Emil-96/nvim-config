return {
	ts_ls = {},
	pyright = {},
	clangd = {},

	gopls = {
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
					shadow = true,
				},
				staticcheck = true,
			}
		},
	},
}
