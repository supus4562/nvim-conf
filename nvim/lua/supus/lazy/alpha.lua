return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 1. Your Custom "SUPUS" Header
    dashboard.section.header.val = {
      [[  ██████  █    ██  ██▓███   █    ██   ██████  ]],
      [[▒██    ▒  ██  ▓██▒▓██░  ██▒ ██  ▓██▒▒██    ▒  ]],
      [[░ ▓██▄    ▓██  ▒██░▓██░ ██▓▒▓██  ▒██░░ ▓██▄    ]],
      [[  ▒   ██▒▓▓█  ░██░▒██▄█▓▒ ▒▓▓█  ░██░  ▒   ██▒ ]],
      [[▒██████▒▒▒▒█████▓ ▒██▒ ░  ░▒▒█████▓ ▒██████▒▒ ]],
      [[▒ ▒▓▒ ▒ ░░▒▓▒ ▒ ▒ ▒▓▒░ ░  ░░▒▓▒ ▒ ▒ ▒ ▒▓▒ ▒ ░ ]],
      [[░ ░▒  ░ ░░░▒░ ░ ░ ░▒ ░     ░░▒░ ░ ░ ░ ░▒  ░ ░ ]],
      [[░  ░  ░   ░░░ ░ ░ ░░        ░░░ ░ ░ ░  ░  ░   ]],
      [[      ░      ░                 ░           ░  ]],
    }

    -- 2. Style the Header
    -- "Include" usually makes it Blue/Cyan. Try "String" for Green or "Type" for Yellow.
    dashboard.section.header.opts.hl = "Include"

    -- 3. The Buttons (Shortcuts)
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
      dashboard.button("r", "  Recent", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "  Find Text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Config", ":cd ~/.config/nvim/ <CR> :e init.lua <CR>"),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- 4. The Footer (Startup Stats)
    dashboard.section.footer.val = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return "Loaded " .. stats.loaded .. " plugins in " .. ms .. "ms"
    end
    dashboard.section.footer.opts.hl = "Comment"

    -- 5. Layout (Padding & Centering)
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.config)
  end,
}
