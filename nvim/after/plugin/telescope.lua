require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			".git/",
			".cache",
			"%.o",
			"%.a",
			"%.out",
			"%.class",
			"%.pdf",
			"%.mkv",
			"%.mp4",
			"%.zip",
			"%.png",
			"%.jpg",
		},
	},
})
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "<leader><Tab>", builtin.buffers, {})
vim.keymap.set("n", "<leader>gr", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
