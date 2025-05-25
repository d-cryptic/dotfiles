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
    opts = {
      log_level = "info",
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true
        }
      },
      history = {
        enabled = true,
        opts = {
          -- Keymap to open history from chat buffer (default: gh)
          keymap = "<leader>gh",
          -- Keymap to save the current chat manually (when auto_save is disabled)
          save_chat_keymap = "<leader>gc",
          -- Save all chats by default (disable to save only manually using 'sc')
          auto_save = true,
          -- Number of days after which chats are automatically deleted (0 to disable)
          expiration_days = 0,
          -- Picker interface (auto resolved to a valid picker)
          picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
          ---Automatically generate titles for new chats
          auto_generate_title = true,
          title_generation_opts = {
            ---Adapter for generating titles (defaults to current chat adapter)
            adapter = "copilot", -- "copilot"
            ---Model for generating titles (defaults to current chat model)
            model = "gpt-4o",    -- "gpt-4o"
          },
          ---On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = true,
          ---When chat is cleared with `gx` delete the chat from history
          delete_on_clearing_chat = false,
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          ---Enable detailed logging for history extension
          enable_logging = false,
        }
      },
      vectorcode = {
        opts = {
          add_tool = true,
        }
      }
    },
    strategies = {
      chat = {
        adapter = "copilot"
      },
      inline = {
        adapter = "copilot",
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
      cmd = {
        adapter = "copilot",
      }
    },
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
        provider = "snacks",                  -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true,        -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      }
    }
  })
}
