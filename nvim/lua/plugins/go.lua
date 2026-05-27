return {
  "ray-x/go.nvim",

  dependencies = {  -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    require("go").setup({
      run_in_floaterm = true,
      floaterm = {   
        posititon = 'right',
        width = 0.45, 
        height = 'auto', 
        title_colors = 'nord', 
      },

      lsp_cfg = true,
      lsp_keymaps = false,
      lsp_codelens = false,
      lsp_inlay_hints = {
        enable = false, -- this is the only field apply to neovim > 0.10
      },
    })

    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.type_definition)
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)
    vim.keymap.set("n", "<leader>rn", require('go.rename').run)
    vim.keymap.set("n", "<leader>gtf", "<cmd>GoTestFunc<CR>")
    vim.keymap.set("n", "<leader>gtF", "<cmd>GoTestFile<CR>")
    vim.keymap.set("n", "<leader>gta", "<cmd>GoAltV<CR>")
    vim.keymap.set("n", "<leader>gta", "<cmd>GoAltV!<CR>")
  end,

  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
