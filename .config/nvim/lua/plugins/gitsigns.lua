return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },
  {
  'SuperBo/fugit2.nvim',
  opts = {
    libgit2_path = "/opt/homebrew/opt/libgit2@1.7/lib/libgit2.1.7.2.dylib",
    width = 70,
    external_diffview = true, -- tell fugit2 to use diffview.nvim instead of builtin implementation.
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    {
      'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
      dependencies = { 'stevearc/dressing.nvim' }
    },
  },
  cmd = { 'Fugit2', 'Fugit2Blame', 'Fugit2Diff', 'Fugit2Graph' },
  keys = {
    { '<leader>gg', mode = 'n', '<cmd>Fugit2<cr>' }
  }
},
{
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- lazy, only load diffview by these commands
  cmd = {
    'DiffviewFileHistory', 'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh'
  }
}
}
