-- vim.g.nvimtree_cache = vim.fn.stdpath "data" .. "/lazy/nvim-tree.lua/"
-- dofile(vim.g.nvimtree_cache .. "nvim-tree.lua")

return {
  {
    "nvim-tree/nvim-web-devicons",
    opt = {
      color_icons = true,
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require("nvim-tree").setup("configs.nvimtree")
    end,
  },
}
