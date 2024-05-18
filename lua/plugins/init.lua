local plugins = {
  { lazy = true, "nvim-lua/plenary.nvim" },

  -- colorscheme
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        -- Your config here
      })
    end,
  },

  -- file tree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- icons, for UI related plugins
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },

  -- buffer + tab line
  {
    "akinsho/bufferline.nvim",
    -- event = "BufReadPre",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require "plugins.configs.bufferline"
    end,
  },
  

  -- statusline

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require "plugins.configs.lualine"
    end,
  },

  -- we use cmp plugin only when in insert mode
  -- so lets lazyload it at InsertEnter event, to know all the events check h-events
  -- completion , now all of these plugins are dependent on cmp, we load them after cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- cmp sources
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",

      -- icons
      "onsails/lspkind.nvim",

      -- snippets
      --list of default snippets
      "rafamadriz/friendly-snippets",

      -- snippets engine
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },

      -- autopairs , autocompletes ()[] etc
      {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup()

          --  cmp integration
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          local cmp = require "cmp"
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
    },
    config = function()
      require "plugins.configs.cmp"
    end,
  },
  ----------- CMP extensions ------------
  -- npm
  {
    "David-Kunz/cmp-npm",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    ft = "json",
    config = function()
      require("cmp-npm").setup()
    end,
  },
  -- crates
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("crates").setup()
    end,
  },
  -- codeium
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        enable_chat = true,
      })
    end
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    config = function()
      require("mason").setup()
    end,
    opts = {
      ensure_installed = {
        "lua-language-server",
        "rust-analyzer",
        "html-lsp",
        "prettier",
        "stylua"
      },
    },
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- formatting , linting
  {
    "stevearc/conform.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.conform"
    end,
  },

  -- -- indent lines
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     require("ibl").setup()
  --   end,
  -- },

  -- files finder etc
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
  },

  -- git status on signcolumn etc
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- comment plugin
  {
    "numToStr/Comment.nvim",
    lazy = true,
    config = function()
      require("Comment").setup()
    end,
  },

  -- dashboard
  {
    "startup-nvim/startup.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require "plugins.configs.startup"
      -- require"startup".setup()
    end
  },
  -- {
  --   'nvimdev/dashboard-nvim',
  --   event = 'VimEnter',
  --   config = function()
  --     require "plugins.configs.dashboard"
  --   end,
  --   dependencies = { {'nvim-tree/nvim-web-devicons'}}
  -- },

  -- notify
  {
    "rcarriga/nvim-notify",
    config = function()
      -- require("plugins.configs.notify")
      require("notify").setup({
      })
    end,
  },

  -- precognition
  -- {
  --   "tris203/precognition.nvim",
  --   event = "BufReadPre",
  --   config = {
  --       -- startVisible = true,
  --       -- showBlankVirtLine = true,
  --       -- hints = {
  --       --     Caret = { text = "^", prio = 1 },
  --       --     Dollar = { text = "$", prio = 1 },
  --       --     w = { text = "w", prio = 10 },
  --       --     b = { text = "b", prio = 10 },
  --       --     e = { text = "e", prio = 10 },
  --       -- },
  --       -- gutterHints = {
  --       --     --prio is not currentlt used for gutter hints
  --       --     G = { text = "G", prio = 1 },
  --       --     gg = { text = "gg", prio = 1 },
  --       --     PrevParagraph = { text = "{", prio = 1 },
  --       --     NextParagraph = { text = "}", prio = 1 },
  --       -- },
  --   }
  -- },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Hop (Better Navigation)
  {
    "smoka7/hop.nvim",
    -- tag = '*',
    lazy = {
      events = "BufEnter",
      cmd = {"HopChar1", "HopChar2", "HopWord", "HopLine"}
    },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
      case_insensitive = false
    }
  },

  -- toggleterm
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- minimap
  {
    "wfxr/minimap.vim",
    build = "cargo install --locked code-minimap",
    lazy = false,
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    init = function()
        vim.cmd("let g:minimap_width = 10")
        vim.cmd("let g:minimap_auto_start = 1")
        vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },

  -- wakatime
  {
    "wakatime/vim-wakatime",
    lazy = false
  }
}

require("lazy").setup(plugins, require "plugins.configs.lazy")

