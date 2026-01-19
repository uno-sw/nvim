local capabilities = require("cmp_nvim_lsp").default_capabilities()


return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = true,
  lsp = {
    capabilities = capabilities,
  },
}
