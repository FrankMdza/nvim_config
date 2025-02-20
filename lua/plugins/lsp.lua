return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- Ensure LSP completion works
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff", "ts_ls", "lua_ls", "rust_analyzer" },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities() -- Move this up!

      -- Python: Pyright (Strict Type Checking)
      lspconfig.pyright.setup({
        capabilities = capabilities, -- Ensure LSP completion works
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict",
            },
          },
        },
      })

      -- Python: Ruff LSP (Linting & Formatting)
      lspconfig.ruff.setup({
        capabilities = capabilities, -- Ensure LSP completion works
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false -- Avoid conflicts with Pyright

          -- Set up formatting using LSP formatting API
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
        settings = {
          ruff = {
            lint = { enable = true },
            format = { enable = true },
          },
        },
      })

      -- TypeScript & JavaScript: ts_ls
      lspconfig.ts_ls.setup({
        capabilities = capabilities, -- Ensure LSP completion works
      })

      -- Lua: Lua Language Server
      lspconfig.lua_ls.setup({
        capabilities = capabilities, -- Ensure LSP completion works
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Rust: Rust Analyzer
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities, -- Ensure LSP completion works
      })
    end,
  },
}
