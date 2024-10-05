return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
	window = {
	    filesystem = {
		window = {
		    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
			["<down>"] = "move_cursor_down",
			["<C-n>"] = "move_cursor_down",
			["<up>"] = "move_cursor_up",
			["<C-e>"] = "move_cursor_up",
			-- ['<key>'] = function(state, scroll_padding) ... end,
		    },
		},   
	    },	
	}
    }
}
