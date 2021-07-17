require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"flake.lock",
			"yarn.lock",
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
})
