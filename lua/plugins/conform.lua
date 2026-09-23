return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      dart = { lsp_format = "prefer" },
    },
    format_on_save = function(bufnr)
      if vim.tbl_contains({ "cpp", "cuda", "objc" }, vim.bo[bufnr].ft) then
        return false
      end
      return { timeout_ms = 3000, lsp_format = "fallback" }
    end,
  },
}
