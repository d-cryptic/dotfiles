return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function()
      return require "configs.mason-lsp"
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("configs.nvim-lsp").defaults()
    end,
    -- opts = function()
    --   local Keys = require("configs.nvim-lsp").get()
    --   -- stylua: ignore
    --   vim.list_extend(Keys, {
    --     { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
    --     { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    --     { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    --     { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    --     { "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = Snacks.picker.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
    --     { "<leader>sS", function() Snacks.picker.picker.lsp_workspace_symbols({ filter = Snacks.picker.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
    --   })
    -- end,
  },
  -- {
  --   'ray-x/navigator.lua',
  --   dependencies = {
  --       { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
  --       { 'neovim/nvim-lspconfig' },
  --   },
  -- }
}
