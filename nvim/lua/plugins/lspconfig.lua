return {
  "neovim/nvim-lspconfig",

  opts = {
    servers = {
      helm_ls = {},
    }
  },

  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- import lspconfig plugin
    local util = require "lspconfig/util"
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    
    -- Configure floating window borders and behavior
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    --   vim.lsp.handlers.hover, {
    --     border = "rounded",
    --     focusable = false,
    --   }
    -- )
    -- -- LSP attach function with K mapping
    -- local on_attach = function(client, bufnr)
    --   local opts = { buffer = bufnr, silent = true }
    --   vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    --   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --   print("LSP attached: " .. client.name .. " to buffer " .. bufnr)
    -- end
    -- 
    -- -- Global fallback keymaps for LSP (in case on_attach doesn't work)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Go to Definition" })
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "LSP Go to Declaration" })
    --
    --
    --
    -- vim.lsp.config("gopls", {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   cmd = {"gopls"},
    --   filetypes = { "go", "gomod", "gowork", "gotmpl" },
    --   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    --   settings = {
    --     gopls = {
    --       completeUnimported = true,
    --       usePlaceholders = true,
    --       gofumpt = true,
    --       analyses = {
    --         unusedparams = true,
    --       },
    --     },
    --   },
    -- })
    --
    -- vim.lsp.enable("gopls", { "go", "gomod", "gowork", "gotmpl" })
    --
    -- Clangd
    --
    vim.lsp.config("clangd", {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "/usr/bin/clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_dir = util.root_pattern(
        '.clangd'
        ,'.clang-tidy'
        ,'.clang-format'
        ,'compile_commands.json'
        ,'compile_flags.txt'
        ,'configure.ac'
        ,'.git'
        ),
      single_file_support = true,
    })
    vim.lsp.enable({"clangd"})

    vim.lsp.config("terraformls", {
      on_attach = on_attach,
      capabilities = capabilities,
    })
    vim.lsp.enable({"terraformls"})

    vim.api.nvim_create_autocmd({"BufWritePre"}, {
      pattern = {"*.tf", "*.tfvars"},
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    vim.lsp.config("ruff", {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {"python"},
    })
    vim.lsp.enable({"ruff"})

    -- setup helm-ls
    vim.lsp.config("helm_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ['helm-ls'] = {
          yamlls = {
            path = "yaml-language-server",
          }
        }
      }
    })
    vim.lsp.enable({"helm_ls"})

  end,
}
