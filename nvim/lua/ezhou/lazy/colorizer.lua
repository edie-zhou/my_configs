return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  config = function()
    vim.opt.termguicolors = true
    require("colorizer").setup({
      -- options go here
    })
  end,
}

