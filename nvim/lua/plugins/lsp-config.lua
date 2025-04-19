---@diagnostic disable: undefined-global
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = { "rust_analyzer", "clangd", "lua_ls", },
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      -- rust-analyzer config
      lspconfig.rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
        },
      })
      -- lua lsp config
      lspconfig.lua_ls.setup({})

      -- Telescope Setup
      local telescope_builtin = require('telescope.builtin')

      -- LSP keybindings
      vim.keymap.set('n', 'rd', telescope_builtin.lsp_definitions, { noremap = true, silent = true })
      vim.keymap.set('n', 'rr', telescope_builtin.lsp_references, { noremap = true, silent = true })
      vim.keymap.set('n', 'ri', telescope_builtin.lsp_implementations, { noremap = true, silent = true })
      --vim.keymap.set('n', 'ra', telescope_builtin.code_action, { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>ds', telescope_builtin.lsp_document_symbols, { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>ws', telescope_builtin.lsp_workspace_symbols, { noremap = true, silent = true })

      --vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      --vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      --vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, {})
      --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
    end,
  },
}
