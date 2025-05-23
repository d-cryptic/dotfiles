return {
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      { "<leader>cs", false },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
    end
  },
  {
    "echasnovski/mini.starter",
    optional = true
  },
  {
    'nvimdev/dashboard-nvim',
    optional = true,
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>sfw", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "<leader>Sfw", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "<leader>sfr", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "<leader>SfR", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>",       mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    cond = true,
    opts = {

      presets = {
        bottom_search = false,
        long_message_to_split = true,
        command_palette = false,
      },

      cmdline = {
        enabled = true,
        view = "cmdline_popup",
      },

      messages = {
        enabled = true,
        commands = {
          history = {
            -- options for the message history that you get with `:Noice`
            view = "split",
          },
          -- :Noice last
          last = {
            view = "popup",
          },
          -- :Noice errors
          errors = {
            -- options for the message history that you get with `:Noice`
            view = "popup",
          },
        },
      },

    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      {
        "rcarriga/nvim-notify",
        opts = {
          render = "minimal", -- default, compact, minimal, simple
          stages = "static",  -- fade, fade_in_slide_out, slide, static
          -- background_colour = "#000000",
          timeout = 1000,
          top_down = true,
        },
      },
    }
  },
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup({
        debounce_threshold = {
          falling = 50,
          rising = 10
        },
        hide = {
          cursorline = "focused_win",
          focused_win = false,
          only_win = false
        },
        highlight = {
          groups = {
            InclineNormal = {
              default = true,
              group = "NormalFloat"
            },
            InclineNormalNC = {
              default = true,
              group = "NormalFloat"
            }
          }
        },
        ignore = {
          buftypes = "special",
          filetypes = {},
          floating_wins = true,
          unlisted_buffers = true,
          wintypes = "special"
        },
        render = "basic",
        window = {
          margin = {
            horizontal = 1,
            vertical = 1
          },
          options = {
            signcolumn = "no",
            wrap = false
          },
          overlap = {
            borders = true,
            statusline = false,
            tabline = false,
            winbar = false
          },
          padding = 1,
          padding_char = " ",
          placement = {
            horizontal = "right",
            vertical = "top"
          },
          width = "fit",
          winhighlight = {
            active = {
              EndOfBuffer = "None",
              Normal = "InclineNormal",
              Search = "None"
            },
            inactive = {
              EndOfBuffer = "None",
              Normal = "InclineNormalNC",
              Search = "None"
            }
          },
          zindex = 50
        }
      }
      )
    end,
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
        { desc = "Toggle Outline" })

      require("outline").setup {
        -- Your setup opts here (leave empty to use defaults)
      }
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
        pattern = opts.filetype_exclude,
        callback = function()
          require('ufo').detach()
        end,
      })

      vim.opt.foldlevelstart = 99
      require('ufo').setup(opts)
    end,
  },
  -- {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'nanozuki/tabby.nvim',
    ---@type TabbyConfig
    -- opts = {
    --   -- configs...
    -- },
  },
  {
    "tpope/vim-surround",
  },
  {
    "tpope/vim-repeat",
  }
  -- { 'echasnovski/mini.nvim', version = '*' },
  -- { 'echasnovski/mini.indentscope', version = '*' },
}
