local base = {
  red = "#ff657a",
  maroon = "#F29BA7",
  peach = "#ff9b5e",
  yellow = "#eccc81",
  green = "#a8be81",
  teal = "#9cd1bb",
  sky = "#A6C9E5",
  sapphire = "#86AACC",
  blue = "#5d81ab",
  lavender = "#66729C",
  mauve = "#b18eab",
}

local extend_base = function(value)
  return vim.tbl_extend("force", base, value)
end

return {
  "catppuccin/nvim",
    name = "catppuccin",
  lazy = false,
  priority = 1000,
  -- flavour = "auto",
  dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    styles = {
      comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
  opts = {
    transparent_background = true,
    background = {
      dark = "frappe",
      light = "latte",
    },
    color_overrides = {
      latte = extend_base({
        text = "#202027",
        subtext1 = "#263168",
        subtext0 = "#4c4f69",
        overlay2 = "#737994",
        overlay1 = "#838ba7",
        base = "#fcfcfa",
        mantle = "#EAEDF3",
        crust = "#DCE0E8",
        pink = "#EA7A95",
        mauve = "#986794",
        red = "#EC5E66",
        peach = "#FF8459",
        yellow = "#CAA75E",
        green = "#87A35E",
      }),
      frappe = extend_base({
        text = "#fcfcfa",
        surface2 = "#535763",
        surface1 = "#3a3d4b",
        surface0 = "#30303b",
        base = "#202027",
        mantle = "#1c1d22",
        crust = "#171719",
      }),
    },
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      flash = true,
      fzf = true,
      grug_far = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      nvimtree = true,
      semantic_tokens = true,
      snacks = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },
  -- specs = {
  --   {
  --     "akinsho/bufferline.nvim",
  --     optional = true,
  --     opts = function(_, opts)
  --       if (vim.g.colors_name or ""):find("catppuccin") then
  --         opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
  --       end
  --     end,
  --   },
  -- }
}
