require('options')
require('keymaps')
require('config.lazy')

if vim.g.neovide then
  require('neovide')
end

vim.g.sync_macos_appearance()

local augroup = vim.api.nvim_create_augroup('WezTermPadding', { clear = true })

vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained'}, {
  group = augroup,
  callback = function ()
    io.write('\x1b]1337;SetUserVar=NVIM_FOCUSED=MQ==\x07')
  end,
})

vim.api.nvim_create_autocmd({ 'VimLeave', 'FocusLost'}, {
  group = augroup,
  callback = function ()
    io.write('\x1b]1337;SetUserVar=NVIM_FOCUSED=MA==\x07')
  end,
})
