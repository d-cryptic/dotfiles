-- 	Plugins or mappings that rely on the file buffer, filetype, or UI being ready only run once everything is truly initialized.
-- 	Prevents flickers or misapplied settings during Neovim startup.

local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, { -- Triggers on UI startup, and buffer read or new buffer creation.
  group = vim.api.nvim_create_augroup("BDFilePost", { clear = true }), -- Creates a unique autocommand group NvFilePost so it can be cleared after use.

  -- Gets the filename and buffer type for the triggered event
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    -- Sets a flag once UIEnter has fired (to prevent duplicate triggering).
    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    -- ensures file has a name, is not a special buffer (like terminal or help), ui if fully initialized
    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      -- Triggers a custom User FilePost autocommand, useful for plugin setups that depend on file buffers being ready.
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      -- Deletes the autocommand group after firing to avoid repeated runs.
      vim.api.nvim_del_augroup_by_name "BDFilePost"

      -- Ensures any FileType autocommands are run after all this setup.
      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        -- Applies .editorconfig rules using the editorconfig.nvim plugin, only if the global flag is set.
        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})
