-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

plugins = {
  -- misc
  "vim-jp/vimdoc-ja",
  "lambdalisue/suda.vim",
  -- UI extend
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "stevearc/dressing.nvim",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  {
    "andymass/vim-matchup",
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  "RRethy/vim-illuminate",
  "lewis6991/gitsigns.nvim",
  "hiphish/rainbow-delimiters.nvim",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
  "onsails/lspkind.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
  },
  -- formatter
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  -- nvim-lint
  "mfussenegger/nvim-lint",
  -- Telescope
  { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
}

require("lazy").setup(plugins, opts)

-- colorscheme
require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    fidget = true,
    gitsigns = true,
    mason = true,
    cmp = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
      indent_blankline = {
        enabled = true,
        scope_color = "lavender",
        colored_indend_levels = false,
      },
    },
    treesitter = true,
    rainbow_delimiters = true,
    telescope = {
      enabled = true,
    },
    illuminate = {
      enabled = true,
      lsp = true,
    },
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin")

-- misc setup
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true

-- bindings
vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set({ "n", "x" }, "<Space>", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Plug>(lsp)", "<Nop>")
vim.keymap.set({ "n", "x" }, "m", "<Plug>(lsp)")
vim.keymap.set({ "n", "x" }, "<Plug>(ff)", "<Nop>")
vim.keymap.set({ "n", "x" }, ";", "<Plug>(ff)")
vim.keymap.set({ "n" }, "<C-p>", "<Cmd>Telescope find_files<CR>")
vim.keymap.set({ "n" }, "<Leader>e", "<Cmd>NvimTreeToggle<CR>")
vim.keymap.set({ "n" }, "<Leader>t", "<Cmd>lua vim.lsp.buf.hover()<CR>")

-- lualine
require("lualine").setup({
  options = {
    theme = "catppuccin",
  },
})

-- indent-blankline
require("ibl").setup()

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

-- treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "astro",
    "bash",
    "css",
    "diff",
    "dockerfile",
    "fish",
    "gitignore",
    "html",
    "ini",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "lua",
    "php",
    "phpdoc",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vue",
    "yaml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  matchup = {
    enable = true,
  },
})

-- rainbow-delimiters
require("rainbow-delimiters.setup")

-- gitsigns
require("gitsigns").setup()

-- mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "astro",
    "bashls",
    "cssls",
    "cssmodules_ls",
    "unocss",
    "denols",
    "dockerls",
    "docker_compose_language_service",
    "eslint",
    "html",
    "jsonls",
    "tsserver",
    "lua_ls",
    "marksman",
    "intelephense",
    "svelte",
    "tailwindcss",
    "volar",
    "yamlls",
  },
  automatic_installation = true,
})

-- LSP
local lsp_signature_config = {}
local cmp = require("cmp")
local lspkind = require("lspkind")
require("lsp_signature").setup(lsp_signature_config)
require("dressing").setup()
require("fidget").setup()

cmp.setup({
  enabled = true,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = "...",
      before = function(entry, vim_item)
        return vim_item
      end,
    }),
  },
})

-- conform.nvim
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    astro = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    jsx = { { "prettierd", "prettier" } },
    tsx = { { "prettierd", "prettier" } },
    vue = { { "prettierd", "prettier" } },
    svelte = { { "prettierd", "prettier" } },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- linter
require("lint").linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  php = { "phpcs" },
}

-- telescope
require("telescope").setup({
  defaults = {
    mappings = {
      n = {
        ["<Esc>"] = require("telescope.actions").close,
      },
      i = {
        ["<Esc>"] = require("telescope.actions").close,
      },
    },
  },
})
require("telescope").load_extension("fzf")
