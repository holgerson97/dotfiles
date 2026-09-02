return {
  "ray-x/go.nvim",

  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
  },

  opts = {
    run_in_floaterm = true,
    floaterm = {
      position = "right",
      width = 0.45,
      height = "auto",
      title_colors = "nord",
    },

    lsp_cfg = true,
    lsp_keymaps = false,
    lsp_codelens = false,
    lsp_inlay_hints = {
      enable = false,
    },
  },

  config = function(_, opts)
    require("go").setup(opts)

    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.type_definition)
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)
    vim.keymap.set("n", "<leader>rn", require("go.rename").run)
    vim.keymap.set("n", "<leader>gtf", "<cmd>GoTestFunc<CR>")
    vim.keymap.set("n", "<leader>gtF", "<cmd>GoTestFile<CR>")
    vim.keymap.set("n", "<leader>gta", "<cmd>GoAltV<CR>")
    vim.keymap.set("n", "<leader>gtA", "<cmd>GoAltV!<CR>")
  end,

  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}
