return {
  "vyfor/cord.nvim",
  build = "cargo build --release",
  event = "VeryLazy",
  opts = {
    log_level = "error",
    -- We are manually pointing to the standard path to avoid auto-detect issues
    advanced = {
      discord = {
        pipe_paths = {
          "/run/user/1000/discord-ipc-0",
        },
      },
    },
  },
}
