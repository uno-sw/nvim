vim.o.termguicolors = true
vim.o.number = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.diagnostic.config({
  virtual_text = true,
  float = { border = "rounded" },
})

local function sync_background()
  local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
  vim.o.background = result:find("Dark") and "dark" or "light"
  if vim.g.colors_name == "catppuccin" then
    vim.cmd.colorscheme("catppuccin")
  end
end

sync_background()

vim.api.nvim_create_autocmd("FocusGained", {
  callback = sync_background,
})
