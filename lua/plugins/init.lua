local plugins = {
  { lazy = true, "nvim-lua/plenary.nvim" },

  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = true,
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
    event = "BufReadPre",
    config = function()
      require "plugins.configs.bufferline"
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

      -- snippets
      --list of default snippets
      "rafamadriz/friendly-snippets",

      -- snippets engine
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require "plugins.configs.luasnip"
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
      ---@diagnostic disable-next-line: different-requires
      require "plugins.configs.cmp"
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    config = function()
      require("mason").setup()
    end,
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

  -- indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("ibl").setup {
        indent = { char = "│" },
        scope = { char = "│", highlight = "Comment" },
      }
    end,
  },

  -- files finder etc
  {
    "nvim-telescope/telescope.nvim",
    -- dependencies = { "debugloop/telescope-undo.nvim" },
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

  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "plugins.configs.todo-comments"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require "plugins.configs.ts-autotag"
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require "plugins.configs.colorizer"
    end,
  },
  {
    "phaazon/hop.nvim",
    config = function()
      require "plugins.configs.hop"
    end,
  },
  {
    "echasnovski/mini.surround",
    config = function()
      require "plugins.configs.mini-surround"
    end,
  },
  {
    "echasnovski/mini.move",
    config = function()
      require "plugins.configs.mini-move"
    end,
  },
  {
    "echasnovski/mini.ai",
    config = function()
      require "plugins.configs.mini-ai"
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    config = function()
      require "plugins.configs.arrow"
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require "plugins.configs.project"
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      dir = vim.fn.stdpath "state" .. "/sessions/", -- directory where session files are saved
      -- minimum number of file buffers that need to be open to save
      -- Set to 0 to always save
      need = 1,
      branch = true, -- use git branch to save session
    },
  },
  {
    "echasnovski/mini.starter",
    config = function()
      require "plugins.configs.mini-starter"
    end,
  },
  {
    "ellisonleao/carbon-now.nvim",
    lazy = true,
    cmd = "CarbonNow",
    config = function()
      require "plugins.configs.carbon-now"
    end,
    ---@param opts cn.ConfigSchema
    -- opts = { [[ your custom config here ]] },
  },
  { "famiu/bufdelete.nvim" },
  {
    "nat-418/boole.nvim",
    config = function()
      require "plugins.configs.boole"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "plugins.configs.lualine"
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  },
  {
    "vigoux/notifier.nvim",
    config = function()
      require("notifier").setup {
        -- You configuration here
      }
    end,
  },
}

require("lazy").setup(plugins, require "lazy_config")
