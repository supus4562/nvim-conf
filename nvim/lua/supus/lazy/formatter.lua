return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- Use clang-format for C and C++ (The "Standard")
        c = { "clang-format" },
        cpp = { "clang-format" },
        -- Use prettier for web stuff if you ever need it
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
      },
      -- Enable "Format on Save"
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })
  end,
}
