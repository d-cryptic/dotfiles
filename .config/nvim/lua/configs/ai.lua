return {
  -- {
  --   require("codecompanion").setup({
  --     strategies = {
  --       chat = {
  --         adapter = "anthropic",
  --       },
  --       inline = {
  --         adapter = "anthropic",
  --       },
  --     },
  --   }),
  -- }
  require("codecompanion").setup({

    strategies = {
      inline = { 
        },
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          send = {
            callback = function(chat)
              vim.cmd("stopinsert")
              chat:submit()
            end,
            index = 1,
            description = "Send",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
    },
    -- extensions = {
    --   vectorcode = {
    --     opts = {
    --       add_tool = true,
    --     }
    --   }
    -- }
  })
}
