require('options')
require('keymaps')
require('config.lazy')

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

