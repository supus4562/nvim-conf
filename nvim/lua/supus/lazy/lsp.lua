return {
  -- The Main LSP Configuration
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Mason: The "App Store" for Language Servers
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion Engine (CMP)
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp", -- Connects LSP to CMP
    "hrsh7th/cmp-buffer", -- Suggest words from current file
    "hrsh7th/cmp-path",   -- Suggest file paths
    "hrsh7th/cmp-cmdline", -- Suggest commands in command line

    -- Snippets (Required for CMP to function)
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    local cmp = require("cmp")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- 1. Setup Mason (The Installer)
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- 2. Setup Mason-LSPConfig (The Bridge)
    require("mason-lspconfig").setup({
      -- List of languages to auto-install (C++ and Lua are default)
      ensure_installed = { "clangd", "lua_ls" },

      handlers = {
        -- The "Default" Handler: Sets up any server you install
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Specific Overrides for C++ (clangd)
        ["clangd"] = function()
          require("lspconfig").clangd.setup({
            capabilities = capabilities,
            cmd = {
              "clangd",
              "--offset-encoding=utf-16", -- Fixes a common Neovim/Clangd crash
            },
          })
        end,

        -- Specific Overrides for Lua
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } }, -- Don't warn about 'vim' global
              },
            },
          })
        end,
      },
    })

    -- 3. Setup Autocompletion (CMP)
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- Move up in menu
        ["<C-j>"] = cmp.mapping.select_next_item(), -- Move down in menu
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),        -- Force open menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter to confirm
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Suggestions from LSP
        { name = "luasnip" }, -- Snippets
        { name = "buffer" }, -- Text from current file
        { name = "path" }, -- File paths
      }),
    })

    -- 4. Global Keymaps (Only active when LSP attaches)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        -- Go to Definition (The most important one)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- Hover Documentation (Read what a function does)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- Rename Variable (Refactoring)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        -- Code Actions (Fix errors automatically)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        -- Show References (Where is this used?)
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
      end,
    })
  end,
}
