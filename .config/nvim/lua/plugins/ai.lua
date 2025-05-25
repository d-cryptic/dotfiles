return {
  { "github/copilot.vim" },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "j-hui/fidget.nvim",
      "ravitemer/codecompanion-history.nvim"
    },
    -- init = function()
    --   require("plugins.fidget"):init()
    -- end,
    config = function(_, opts)
      local spinner = require("configs.spinner")
      spinner:init()
      -- Setup the entire opts table
      require("codecompanion").setup(opts)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function() require("copilot_cmp").setup() end,
    dependencies = {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end,
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" }
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = true,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup()
    end
  },
  {
    "Davidyz/VectorCode",
    version = "*",                     -- optional, depending on whether you're on nightly or release
    build = "pipx upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return {
        async_backend = "lsp",
        notify = true,
        on_setup = { lsp = false },
        n_query = 10,
        timeout_ms = -1,
        async_opts = {
          events = { "BufWritePost" },
          single_job = true,
          --query_cb = require("vectorcode.utils").make_surrounding_lines_cb(40),
          debounce = -1,
          n_query = 30,
        },
      }
    end,
    -- config = function(_, opts)
    --   vim.lsp.config("vectorcode_server", {
    --     cmd_env = {
    --       HTTP_PROXY = os.getenv("HTTP_PROXY"),
    --       HTTPS_PROXY = os.getenv("HTTPS_PROXY"),
    --     },
    --   })
    --   require("vectorcode").setup(opts)
    --   -- vim.api.nvim_create_autocmd("LspAttach", {
    --   --   callback = function()
    --   --     require("vectorcode.config").get_cacher_backend().register_buffer(0)
    --   --   end,
    --   -- })
    -- end,
    cmd = "VectorCode",
    -- cond = function()
    --   return vim.fn.executable("vectorcode") == 1 and utils.no_vscode()
    -- end,

  }

  -- {
  --   "Davidyz/VectorCode",
  --   version = "*",                     -- optional, depending on whether you're on nightly or release
  --   build = "pipx upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- }
}
