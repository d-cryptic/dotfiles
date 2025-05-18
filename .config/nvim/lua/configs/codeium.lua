return {

  require("codeium").setup({
    virtual_text = {
      enabled = true,
    },
  })

  require('codeium.virtual_text').set_statusbar_refresh(function()
    require('lualine').refresh()
  end)
}

-- local neocodeium = require("neocodeium")
-- local cmp = require("cmp")
-- local commands = require("neocodeium.commands")
--
-- local neocodeium = require("neocodeium")
-- local function get_neocodeium_status(ev)
--   local status, server_status = neocodeium.get_status()
--   -- process this data, convert it to custom string/icon etc and set buffer variable
--   if status == 0 then
--     vim.api.nvim_buf_set_var(ev.buf, "neocodeium_status", "OK")
--   else
--     vim.api.nvim_buf_set_var(ev.buf, "neocodeium_status", "OFF")
--   end
--   vim.cmd.redrawstatus()
-- end
--
--
-- return {
--   cmp.event:on("menu_opened", function()
--     neocodeium.clear()
--   end)
--
--   neocodeium.setup({
--     filter = function()
--       return not cmp.visible()
--     end,
--     filter = function(bufnr)
--       if vim.tbl_contains(filetypes, vim.api.nvim_get_option_value('filetype', { buf = bufnr })) then
--         return true
--       end
--       return false
--     end
--   })
--
--   cmp.setup({
--     completion = {
--       autocomplete = false,
--     },
--   })
--
--   vim.api.nvim_create_autocmd("User", {
--     -- group = ..., -- set some augroup here
--     pattern = {
--       "NeoCodeiumServer*",
--       "NeoCodeium*Enabled",
--       "NeoCodeium*Disabled",
--     }
--     callback = get_neocodeium_status,
--   })
--
--   -- add neocodeium_status to your statusline
--   vim.opt.statusline:append("%{get(b:, 'neocodeium_status', '')%}")
--
-- }
