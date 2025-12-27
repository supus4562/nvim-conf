return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15, -- Height of the terminal
      open_mapping = [[<C-\>]], -- The key to toggle it (Ctrl + Backslash)
      direction = "horizontal", -- Opens at the bottom
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true, -- Whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- Whether or not the open mapping applies in the open terminal
      persist_size = true,
      close_on_exit = true, -- Close the terminal window when the process exits
      shell = vim.o.shell, -- Use your default shell (zsh)
    })
  end,
}
