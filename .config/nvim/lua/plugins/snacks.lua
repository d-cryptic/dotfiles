local picker = {
  name = "snacks",
  commands = {
    files = "files",
    live_grep = "grep",
    oldfiles = "recent",
  },

  open = function(source, opts)
    return Snacks.picker.pick(source, opts)
  end,
}

-- vim.g.snacks = "snacks"

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    desc = "Snacks File Explorer",
    recommended = true,
    "folke/snacks.nvim",
    opts = {
      explorer = {},
      picker = {
        win = {
          input = {
            keys = {
              ["<a-c>"] = {
                "toggle_cwd",
                mode = { "n", "i" },
              },
            },
          },
        },
        actions = {
          toggle_cwd = function(p)
            local root = vim.fs.root(0, { '.git', 'lua' }) { buf = p.input.filter.current_buf, normalize = true }
            local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
            local current = p:cwd()
            p:set_cwd(current == root and cwd or root)
            p:find()
          end,
        },
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },
      { "<leader>b",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>G",       function() Snacks.picker.pick("grep") end,                              desc = "Grep (Root Dir)" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader><space>", function() Snacks.picker.pick("files") end,                             desc = "Find Files (Root Dir)" },
      { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
      -- find
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fB",      function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
      { "<leader>fc",      function() Snacks.picker.pick.config_files() end,                       desc = "Find Config File" },
      { "<leader>ff",      function() Snacks.picker.pick("files") end,                             desc = "Find Files (Root Dir)" },
      { "<leader>fF",      function() Snacks.picker.pick("files", { root = false }) end,           desc = "Find Files (cwd)" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Files (git-files)" },
      { "<leader>fr",      function() Snacks.picker.pick("oldfiles") end,                          desc = "Recent" },
      { "<leader>fR",      function() Snacks.picker.recent({ filter = { cwd = true } }) end,       desc = "Recent (cwd)" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
      -- git
      { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (hunks)" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      -- Grep
      { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg",      function() Snacks.picker.pick("live_grep") end,                         desc = "Grep (Root Dir)" },
      { "<leader>sG",      function() Snacks.picker.pick("live_grep", { root = false }) end,       desc = "Grep (cwd)" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
      { "<leader>sw",      function() Snacks.picker.pick("grep_word") end,                         desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      { "<leader>sW",      function() Snacks.picker.pick("grep_word", { root = false }) end,       desc = "Visual selection or word (cwd)",      mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undotree" },
      -- ui
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
    },
  },
  {
    ---@module "snacks"
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    optional = false,
    keys = {
      { "<leader>st", function() require("snacks").picker.todo_comments() end,                                           desc = "Todo" },
      { "<leader>sT", function() require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,  desc = "Todo/Fix/Fixme" },
    },
  },

}
