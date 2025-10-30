return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()

    -- import lspconfig plugin
    local util = require "lspconfig/util"

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    vim.lsp.config("gopls", {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {"gopls"},
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          gofumpt = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    })

    vim.lsp.config("tsserver", {
      on_attach = on_attach,
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      cmd = { "typescript-language-server", "--stdio" }
    })

    -- Clangd
    vim.lsp.config("clangd", ({
      on_attach = lsp_attach,
      capabilities = capabilities,
      cmd = { "/usr/bin/clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_dir = vim.lsp.config.util.root_pattern(
        '.clangd'
        ,'.clang-tidy'
        ,'.clang-format'
        ,'compile_commands.json'
        ,'compile_flags.txt'
        ,'configure.ac'
        ,'.git'
        ),
      single_file_support = true,
    }))

    -- setup helm-ls
    vim.lsp.config("helm_ls", {
      settings = {
        ['helm-ls'] = {
          yamlls = {
            path = "yaml-language-server",
          }
        }
      }
    })
  end,
}
