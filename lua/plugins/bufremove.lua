return {
  "nvim-mini/mini.bufremove",
  version = false,
  keys = {
    {
      "<leader>bd",
      function()
        require("mini.bufremove").delete(0, false)
      end,
      desc = "Delete buffer",
    },
  },
}
