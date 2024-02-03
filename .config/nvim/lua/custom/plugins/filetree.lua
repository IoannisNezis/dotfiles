-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require('neo-tree').setup({
			filesystem = {
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						'.git',
						-- '.DS_Store',
						-- 'thumbs.db',
					},
					never_show = {},
				},
			}
		})
		vim.keymap.set('n', '<C-m>', '<cmd>:Neotree<CR>', { desc = "Filetree" })
		vim.keymap.set({ 'n', 'i' }, '<C-n>', '<cmd>:Neotree toggle<CR>', { desc = "Toggle filetree" })
	end,
}
