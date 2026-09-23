return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install {
      'c',
      'dart',
      'javascript',
      'lua',
      'typescript',
    }
  end,
}
