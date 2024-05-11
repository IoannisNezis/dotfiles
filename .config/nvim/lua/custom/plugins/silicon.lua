return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	init = function ()
		local wk = require("which-key")
		wk.register({
			["<leader>sc"] = { ":Silicon<CR>", "[S]napshot [C]ode" },
		}, { mode = "v"})
	end,
	config = function ()
		require("silicon").setup({
			font = "Hack Nerd Font=34;Noto Color Emoji=34",
			theme = "Dracula",
			background = "#94e2d5",
			window_title = function ()
				return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
			end,
		})
	end
}
