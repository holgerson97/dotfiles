return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    local util = require "lspconfig/util"
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    lspconfig.gopls.setup {
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
    }

    -- Clangd
    lspconfig.clangd.setup({
      on_attach = lsp_attach,
      capabilities = capabilities,
      cmd = { "/usr/bin/clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_dir = lspconfig.util.root_pattern(
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

    lspconfig.terraformls.setup{}
    vim.api.nvim_create_autocmd({"BufWritePre"}, {
      pattern = {"*.tf", "*.tfvars"},
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    lspconfig.ruff.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {"python"},
    }

    -- setup helm-ls
    lspconfig.helm_ls.setup {
      settings = {
        ['helm-ls'] = {
          yamlls = {
            path = "yaml-language-server",
          }
        }
      }
    }
  end,
}
