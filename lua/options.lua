vim.o.termguicolors = true
vim.o.number = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.wrap = true

vim.diagnostic.config({
  virtual_text = true,
  float = { border = "rounded" },
})

-- Change these two values to switch which themes are used for each appearance.
local themes = {
  light = "kanagawa-lotus",
  dark = "catppuccin-frappe",
}

local function sync_background(apply_colorscheme)
  local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local is_dark = result:find("Dark") ~= nil

  if is_dark then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end

  if apply_colorscheme then
    vim.cmd.colorscheme(is_dark and themes.dark or themes.light)
  end
end

sync_background(false)

vim.g.sync_macos_appearance = function()
  sync_background(true)
end

vim.api.nvim_create_autocmd("FocusGained", {
  -- Allow bufferline and other plugins to handle the colorscheme change.
  nested = true,
  callback = vim.g.sync_macos_appearance,
})
