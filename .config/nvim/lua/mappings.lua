local map = vim.keymap.set

-- in insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })

map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Nvimtree
-- nvimtree
-- map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- which key
-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- Conform formatting
map({ "n", "x" }, "<leader>Fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- Format before every save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    require("conform").format { lsp_fallback = true }
  end,
})

-- Mason
map({ "n" }, "<leader>ma", "<cmd>Mason<CR>", { desc = "mason toggle window" })

-- Telescope
-- telescope
map("n", "<leader>Fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>Fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>Fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>Fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>Fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>Ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>Fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

vim.keymap.set({ "n", "v" }, "<leader>A", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
vim.keymap.set("n", "<leader>T", ":Today<CR>", { noremap = true, silent = true, desc = "Open today's note" })

-- Add fidget
local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "CodeCompanionRequest*",
  group = group,
  callback = function(request)
    local msg

    if request.match == "CodeCompanionRequestStarted" then
      msg = "[CodeCompanion] starting..."
    elseif request.match == "CodeCompanionRequestStreaming" then
      msg = "[CodeCompanion] streaming..."
    else
      msg = "[CodeCompanion] finished"
    end

    vim.notify(msg, "info", {
      id = "code_companion_status",
      title = "Code Companion Status",
      opts = function(notif)
        notif.icon = request.match == "CodeCompanionRequestFinished" and " "
            ---@diagnostic disable-next-line: undefined-field
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- -- neocodeium
-- vim.keymap.set("n", "<leader>ca", function()
--   require("neocodeium").accept()
-- end, { desc = "Neocodeium accept" })
-- vim.keymap.set("n", "<leader>cw", function()
--   require("neocodeium").accept_word()
-- end, { desc = "Neocodeium accept word" })
-- vim.keymap.set("n", "<leader>cL", function()
--   require("neocodeium").accept_line()
-- end, { desc = "Neocodeium accept line" })
-- vim.keymap.set("n", "<leader>cc", function()
--   require("neocodeium").cycle_or_complete()
-- end, { desc = "Neocodeium cycle or complete" })
-- vim.keymap.set("n", "<leader>cr", function()
--   require("neocodeium").cycle_or_complete(-1)
-- end, { desc = "Neocodeium cycle or complete reverse" })
-- vim.keymap.set("i", "<leader>cx", function()
--   require("neocodeium").clear()
-- end, { desc = "Neocodeium clear" })
