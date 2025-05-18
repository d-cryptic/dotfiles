return {
  {
	"stevearc/conform.nvim",
		opts = {
  	-- 	formatters_by_ft = {
			-- lua = {
			-- 	"stylua",
			-- },
			-- 	css = {
			-- 	"prettier",
			-- },
			-- 	html = {
			-- 	"prettier",
			-- },
			-- 	sh = {
			-- 	"beautysh",
			-- 		"shellcheck",
			-- },
			-- 	json = {
			-- 	"yq",
			-- },
			-- 	yaml = {
			-- 	"yamlfmt",
			-- },
			-- 	yml = {
			-- 	"yamlfmt",
			-- },
			-- 	xml = {
			-- 	"xmllint",
			-- },
			-- 	py = {
			-- 	"usort",
			-- 		"autopep8",
			-- 		"black",
			-- 		"darker",
			-- 		"isort",
			-- 		"ruff_fix",
			-- 		"ruff_format",
			-- 		"ruff_organize_imports",
			-- },
			-- 	["*"] = {
			-- 	"codespell",
			-- 		"indent",
			-- 		"trim_newlines",
			-- 		"trim_whitespace",
			-- },
			-- 	go = {
			-- 	"gofmt",
			-- 		"goimports",
			-- 		"golangci-lint",
			-- },
			-- 	md = {
			-- 	"mdformat",
			-- },
			-- 	rs = {
			-- 	"rustfmt",
			-- },
			-- 	sql = {
			-- 	"sqlfmt",
			-- },
			-- 	tf = {
			-- 	"terraform_fmt",
			-- },
		-- },
			format_on_save = {
			timeout_ms = 500,
				lsp_fallback = true,
        async = false
		},
	},
  {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })


    vim.keymap.set("n", "<leader>L", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
}
}

