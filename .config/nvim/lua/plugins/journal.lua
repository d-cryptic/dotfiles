return {
  'VVoruganti/today.nvim',
  config = function()
    require('today').setup({
      local_root = "/Users/admin/Documents/journal"
      -- local_root = "~/Documents/journal", -- Default: ~/.today
      -- template = "custom_template.md"      -- Default: jrnl.md
    })
  end
}
