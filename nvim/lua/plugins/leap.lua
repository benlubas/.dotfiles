return {
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			local opts = leap.opts

			leap.add_default_mappings()

			-- basically just stripping away as much as possible.
			opts.highlight_unlabeled_phase_one_targets = true
			opts.max_highlighted_traversal_targets = 0
			opts.case_sensitive = false
			opts.substitute_chars = {}
			opts.safe_labels = {}
			opts.labels = {}
			opts.special_keys = {
				repeat_search = "",
				next_phase_one_target = "",
				next_target = { ";" },
				prev_target = { "," },
				next_group = "",
				prev_group = "",
				multi_accept = "",
				multi_revert = "",
			}
		end,
	},
}
