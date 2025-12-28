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
    vim.lsp.enable({"gopls"})

    -- Clangd
    vim.lsp.config("clangd", {
      on_attach = lsp_attach,
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

    vim.lsp.config("terraformls", {})
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
