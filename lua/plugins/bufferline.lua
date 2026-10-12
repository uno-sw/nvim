return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin",
  },
  version = "*",
  config = {
    options = {
      diagnostics = "nvim_lsp",
      numbers = "ordinal",
      separator_style = "slant",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
        },
      },
      close_command = function(bufnr)
        require("mini.bufremove").delete(bufnr, false)
      end,
      right_mouse_command = function(bufnr)
        require("mini.bufremove").delete(bufnr, false)
      end,
    },
  }
}
