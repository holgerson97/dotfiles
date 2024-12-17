return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "private",
          path = "~/Documents/private",
        },
      },
      daily_notes = {
        folder = "03 - Daily Notes/",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%d-%m-%y",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%-d %B, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        template = "daily.md"
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      templates = {
        folder = "templates",
        date_format = "%d-%m-%Y-%a",
        time_format = "%H:%M",
      },
    })
  end,
}
