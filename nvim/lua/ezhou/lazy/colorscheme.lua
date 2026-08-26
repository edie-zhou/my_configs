return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("gruvbox").setup({
      contrast = "hard",        -- "hard" | "soft" | ""
      terminal_colors = true,
      transparent_mode = false,
      italic = {
        strings = false,        -- the classic gruvbox look; set true if you like italics
        comments = true,
      },
    })

    vim.o.background = "dark"   -- must come before the colorscheme call
    vim.cmd.colorscheme("gruvbox")
  end,
}
