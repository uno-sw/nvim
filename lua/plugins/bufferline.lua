return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin",
  },
  version = "*",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        numbers = "ordinal",
        indicator = {
          style = "underline",
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
          },
        },
      },
      highlights = require("catppuccin.special.bufferline").get_theme(),
    })
  end,
}
