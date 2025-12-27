return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Uses your Nerd Font
  config = function()
    local nvimtree = require("nvim-tree")

    -- Disable standard netrw (standard vim explorer) to avoid conflicts
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 30, -- Width of the sidebar
        side = "left",
      },
      renderer = {
        indent_markers = {
          enable = true, -- Shows lines connecting nested folders
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- Arrow for closed folder
              arrow_open = "",   -- Arrow for open folder
            },
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Keep sidebar open after selecting a file (VS Code style)
        },
      },
      git = {
        enable = true,
        ignore = false, -- Show .gitignore files (Computer Scientists need to see everything)
      },
    })
  end,
}
