-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- lvim.format_on_save = true
lvim.transparent_window = true
vim.opt.guicursor = ""
vim.opt.wrap = true

lvim.lsp.null_ls.config = {
  enabled = true
}
require 'lspconfig'.astro.setup {}
vim.filetype.add {
  extension = {
    astro = "astro",
  },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "astro", "css" }
  },
}

lvim.plugins = {

  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        neovim_image_text = "lol",
        main_image        = "file"
      })
    end
  },
  {
    "ThePrimeagen/vim-be-good"
  }, {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    'smoka7/hydra.nvim',
  },
  opts = {},
  cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
  keys = {
    {
      mode = { 'v', 'n' },
      '<Leader>m',
      '<cmd>MCstart<cr>',
      desc = 'Create a selection for selected text or word under the cursor',
    },
  },
}
}

lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 2000 }
  end,
  "Format",
}


lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "yaml",
  "prisma",
  "astro",
  "rust",
}
