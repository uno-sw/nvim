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

local function sync_background(apply_colorscheme)
  local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local is_dark = result:find("Dark") ~= nil
  vim.o.background = is_dark and "dark" or "light"

  if not apply_colorscheme then
    return
  end

  if is_dark then
    vim.cmd.colorscheme("tokyonight-night")
  else
    vim.cmd.colorscheme("tokyonight-day")
  end
end

sync_background(false)

vim.g.sync_macos_appearance = function()
  sync_background(true)
end

vim.api.nvim_create_autocmd("FocusGained", {
  callback = vim.g.sync_macos_appearance,
})
