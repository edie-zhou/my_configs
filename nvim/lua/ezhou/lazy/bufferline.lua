return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'ellisonleao/gruvbox.nvim',
  },
  config = function()
    vim.cmd.colorscheme("gruvbox")
    vim.opt.termguicolors = true
    require('bufferline').setup {}
  end
}
