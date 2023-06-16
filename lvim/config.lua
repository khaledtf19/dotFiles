--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.lsp.null_ls.config = {
  enabled = true
}
lvim.transparent_window = true
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

-- local capabilities = require("lvim.lsp").common_capabilities()


-- -- Set a formatter.

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "astro", "css" }
  },
}

lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 2000 }
  end,
  "Format",
}

-- for _, language in ipairs { "typescript", "javascript" } do
--   require("dap").configurations[language] = {
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Debug Jest Tests",
--       -- trace = true, -- include debugger info
--       runtimeExecutable = "node",
--       runtimeArgs = {
--         "./node_modules/jest/bin/jest.js",
--         "--runInBand",
--       },
--       rootPath = "${workspaceFolder}",
--       cwd = "${workspaceFolder}",
--       console = "integratedTerminal",
--       internalConsoleOptions = "neverOpen",
--     },
--   }
-- end

-- -- Set a linter.
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "eslint", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "astro" } },
})
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
--
vim.opt.guicursor = ""
vim.opt.wrap = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- if you don't want all the parsers change this to a table of the ones you want
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
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

lvim.plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
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
    'Exafunction/codeium.vim',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
}

-- local h = require("null-ls.helpers")
-- local cmd_resolver = require("null-ls.helpers.command_resolver")
-- local methods = require("null-ls.methods")
-- local u = require("null-ls.utils")

-- local FORMATTING = methods.internal.FORMATTING
-- local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

-- require("null-ls").register({
--   --your custom sources go here
--   h.make_builtin({
--     name = "prettier",
--     meta = {
--       url = "https://github.com/prettier/prettier",
--       description =
--       [[Prettier is an opinionated code formatter. It enforces a consistent style by parsing your code and re-printing it with its own rules that take the maximum line length into account, wrapping code when necessary.]],
--       notes = {
--         [[Supports more filetypes such as [Svelte](https://github.com/sveltejs/prettier-plugin-svelte) and [TOML](https://github.com/bd82/toml-tools/tree/master/packages/prettier-plugin-toml) via plugins. These filetypes are not enabled by default, but you can follow the instructions [here](BUILTIN_CONFIG.md#filetypes) to define your own list of filetypes.]],
--         [[To increase speed, you may want to try [prettierd](https://github.com/fsouza/prettierd). You can also set up [eslint-plugin-prettier](https://github.com/prettier/eslint-plugin-prettier) and format via [eslint_d](https://github.com/mantoni/eslint_d.js/).]],
--       },
--     },
--     method = { FORMATTING, RANGE_FORMATTING },
--     filetypes = {
--       "javascript",
--       "javascriptreact",
--       "typescript",
--       "typescriptreact",
--       "vue",
--       "css",
--       "scss",
--       "less",
--       "html",
--       "json",
--       "jsonc",
--       "yaml",
--       "markdown",
--       "markdown.mdx",
--       "graphql",
--       "handlebars",
--     },
--     generator_opts = {
--       command = "prettier",
--       args = h.range_formatting_args_factory({
--         "--stdin-filepath",
--         "$FILENAME",
--       }, "--range-start", "--range-end", { row_offset = -1, col_offset = -1 }),
--       to_stdin = true,
--       dynamic_command = cmd_resolver.from_node_modules(),
--       cwd = h.cache.by_bufnr(function(params)
--         return u.root_pattern(
--         -- https://prettier.io/docs/en/configuration.html
--           ".prettierrc",
--           ".prettierrc.json",
--           ".prettierrc.yml",
--           ".prettierrc.yaml",
--           ".prettierrc.json5",
--           ".prettierrc.js",
--           ".prettierrc.cjs",
--           ".prettierrc.toml",
--           "prettier.config.js",
--           "prettier.config.cjs"
--         )(params.bufname)
--       end),
--     },
--     factory = h.formatter_factory,
--   })
-- })
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "prettier", filetypes = { "typescript", "typescriptreact" } },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "eslint",     filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
--   { command = "write-good", filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
-- }
-- h.make_builtin({
--   name = "prettier",
--   meta = {
--     url = "https://github.com/prettier/prettier",
--     description =
--     [[Prettier is an opinionated code formatter. It enforces a consistent style by parsing your code and re-printing it with its own rules that take the maximum line length into account, wrapping code when necessary.]],
--     notes = {
--       [[Supports more filetypes such as [Svelte](https://github.com/sveltejs/prettier-plugin-svelte) and [TOML](https://github.com/bd82/toml-tools/tree/master/packages/prettier-plugin-toml) via plugins. These filetypes are not enabled by default, but you can follow the instructions [here](BUILTIN_CONFIG.md#filetypes) to define your own list of filetypes.]],
--       [[To increase speed, you may want to try [prettierd](https://github.com/fsouza/prettierd). You can also set up [eslint-plugin-prettier](https://github.com/prettier/eslint-plugin-prettier) and format via [eslint_d](https://github.com/mantoni/eslint_d.js/).]],
--     },
--   },
--   method = { FORMATTING, RANGE_FORMATTING },
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "typescript",
--     "typescriptreact",
--     "vue",
--     "css",
--     "scss",
--     "less",
--     "html",
--     "json",
--     "jsonc",
--     "yaml",
--     "markdown",
--     "markdown.mdx",
--     "graphql",
--     "handlebars",
--   },
--   generator_opts = {
--     command = "prettier",
--     args = h.range_formatting_args_factory({
--       "--stdin-filepath",
--       "$FILENAME",
--     }, "--range-start", "--range-end", { row_offset = -1, col_offset = -1 }),
--     to_stdin = true,
--     dynamic_command = cmd_resolver.from_node_modules(),
--     cwd = h.cache.by_bufnr(function(params)
--       return u.root_pattern(
--       -- https://prettier.io/docs/en/configuration.html
--         ".prettierrc",
--         ".prettierrc.json",
--         ".prettierrc.yml",
--         ".prettierrc.yaml",
--         ".prettierrc.json5",
--         ".prettierrc.js",
--         ".prettierrc.cjs",
--         ".prettierrc.toml",
--         "prettier.config.js",
--         "prettier.config.cjs",
--         "package.json"
--       )(params.bufname)
--     end),
--   },
--   factory = h.formatter_factory,
-- })
-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
-- })
