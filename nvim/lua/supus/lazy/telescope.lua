return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8", -- Use a stable release
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required lua library
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Compiles C-based sorter
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- Move up
            ["<C-j>"] = actions.move_selection_next,     -- Move down
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    -- Load the FZF extension for speed
    telescope.load_extension("fzf")
  end,
}
