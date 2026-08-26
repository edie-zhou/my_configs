local which_key = require "which-key"
local builtin = require('telescope.builtin')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }
    local mappings = {
      {
        buffer = event.buf, -- v3 takes buffer inside the spec, not as a second arg
        { "gd",         vim.lsp.buf.definition,                                           desc = "Go to definition" },
        { "gl",         vim.diagnostic.open_float,                                        desc = "Open diagnostic float" },
        { "K",          vim.lsp.buf.hover,                                                desc = "Show hover information" },
        { "<leader>l",  group = "LSP" }, -- was `name = "LSP"`
        { "<leader>la", vim.lsp.buf.code_action,                                          desc = "Code action" },
        { "<leader>lr", vim.lsp.buf.references,                                           desc = "References" },
        { "<leader>ln", vim.lsp.buf.rename,                                               desc = "Rename" },
        { "<leader>lw", vim.lsp.buf.workspace_symbol,                                     desc = "Workspace symbol" },
        { "<leader>ld", vim.diagnostic.open_float,                                        desc = "Open diagnostic float" },
        -- goto_next/goto_prev are deprecated on 0.11+; jump() replaces both
        { "]d",         function() vim.diagnostic.jump({ count = 1, float = true }) end,  desc = "Go to next diagnostic" },
        { "[d",         function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Go to previous diagnostic" },
      },
    }
    which_key.add(mappings)
    -- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    -- vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    -- vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    -- vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    -- vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    -- vim.keymap.set('n', '<leader>lca', function() vim.lsp.buf.code_action() end, opts)
    -- vim.keymap.set('n', '<leader>lrr', function() vim.lsp.buf.references() end, opts)
    -- vim.keymap.set('n', '<leader>lrn', function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

    -- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = event.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = event.data.client_id }
      end
    })
  end,
})

local non_lsp_mappings = {
  { "<leader>e", vim.cmd.Ex,                                             desc = "Open file explorer" },
  { "<leader>p", "\"_dP",                                                desc = "Paste without overwrite" },
  { "<leader>/", "<Plug>(comment_toggle_linewise_current)",              desc = "Toggle comment" },
  { "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Search and replace word under cursor" },
  { "<leader>t", ":Today<CR>",                                           desc = "Open today's note" },
  { "J",         "mzJ`z",                                                desc = "Join lines and keep cursor position" },
  { "<C-d>",     "<C-d>zz",                                              desc = "Half page down and center" },
  { "<C-u>",     "<C-u>zz",                                              desc = "Half page up and center" },
  { "n",         "nzzzv",                                                desc = "Next search result and center" },
  { "N",         "Nzzzv",                                                desc = "Previous search result and center" },
  { "Q",         "<nop>",                                                desc = "Disable Ex mode" },
}
which_key.add(non_lsp_mappings)
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
-- vim.keymap.set("n", "J", "mzJ`z")       -- Keep cursor in same position on line join
-- vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Keep cursor in middle on half page jump down
-- vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Keep cursor in middle on half page jump down
-- vim.keymap.set("n", "n", "nzzzv")       -- Keep searched term in middle
-- vim.keymap.set("n", "N", "Nzzzv")       -- Keep reverse searched term in middle
-- vim.keymap.set("n", "Q", "<nop>")       --- Just undo capital Q support
-- vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)")
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>t", ":Today<CR>")

-- Telescope Commands
-- v3 has no `prefix` option -- write the full <leader>f… keys out
local telescope_mappings = {
  { "<leader>f",  group = "Find" },
  { "<leader>ff", builtin.find_files, desc = "Find files" },
  { "<leader>fg", builtin.git_files,  desc = "Find git files" },
  { "<leader>fl", builtin.live_grep,  desc = "Live grep" },
  -- the semicolon mapping doesn't use the leader prefix, but with no `prefix`
  -- option it can live in the same table now
  { ";",          builtin.buffers,    desc = "Find buffers" },
}
which_key.add(telescope_mappings)
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
-- vim.keymap.set('n', ';', builtin.buffers, {})

-- Use move command while highlighted to move text
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)")
local visual_mappings = {
  {
    mode = { "v" }, -- mode moves inside the spec, wrapping the entries
    { "J",         ":m '>+1<CR>gv=gv",                       desc = "Move selection down" },
    { "K",         ":m '<-2<CR>gv=gv",                       desc = "Move selection up" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment" },
  },
}
which_key.add(visual_mappings)

--- Don't overwrite pastes in visual mode
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- Format command
-- vim.keymap.set("n", "<leader>f", function()
-- vim.lsp.buf.format()
-- end)

-- insert commands
vim.keymap.set('i', '<Right>', '<Right>', { noremap = true }) -- Make the right arrow behave normally in insert mode
