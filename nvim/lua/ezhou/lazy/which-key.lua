return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    delay = 300, -- delay before the popup appears (v3 uses this, not timeoutlen)
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = true,
        suggestions = 20
      },
      presets = {
        operators = false,    -- adds help for operators like d, y, ...
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false,      -- default bindings on <c-w>
        nav = false,          -- misc bindings to work with windows
        z = false,            -- bindings for folds, spelling and others prefixed with z
        g = false,            -- bindings for prefixed with g
      },
    },

    keys = {
      scroll_down = "<c-d>",   -- binding to scroll down inside the popup
      scroll_up = "<c-u>",     -- binding to scroll up inside the popup
    },
    win = {                        -- was `window`
      border = "single",           -- none, single, double, shadow
      padding = { 2, 2 },          -- extra window padding [vertical, horizontal] -- v2 took 4 values
      wo = {
        winblend = 0,              -- window-local options now live under `wo`
      },
      -- `position` and `margin` are gone in v3 -- the window places itself
    },
    layout = {
      width = { min = 20 }, -- min width of the columns -- `max` and `height` are computed in v3
      spacing = 3,          -- spacing between columns
      align = "left",       -- align columns left, center or right
    },

    show_help = true, -- show help message on the command line when the popup is visible
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers = {
      -- mode string omits `i`, which covers v2's triggers_blacklist = { i = { "j", "k" } }.
      -- the `v` half of that blacklist was always a no-op -- j/k prefix nothing.
      { "<auto>", mode = "nxso" }, -- n, visual, select, operator-pending
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by default for Telescope
    disable = {
      bt = {},                     -- was `buftypes`
      ft = { "TelescopePrompt" },  -- was `filetypes`
    },
  }
}

