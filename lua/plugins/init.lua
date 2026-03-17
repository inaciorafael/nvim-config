local plugins = {
  { lazy = true, "nvim-lua/plenary.nvim" },

  -- icons, for UI related plugins
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end,
    event = "UIEnter",
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
    event = { "BufReadPre", "BufNewFile" },
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
    -- Esta linha é CRÍTICA - força o carregamento imediato
    lazy = false,
    -- Prioridade alta para carregar antes de outros plugins
    priority = 1000,
    -- Configuração simplificada
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    config = function()
      require("mason").setup()
    end,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
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
    event = { "BufWritePre" },
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
    cmd = "Oil",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    config = function()
      require "plugins.configs.todo-comments"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact", "vue", "svelte", "angular" },
    config = function()
      require "plugins.configs.ts-autotag"
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require "plugins.configs.colorizer"
    end,
  },
  {
    "phaazon/hop.nvim",
    cmd = { "HopChar1", "HopChar1CurrentLine" },
    config = function()
      require "plugins.configs.hop"
    end,
  },
  {
    "echasnovski/mini.surround",
    config = function()
      require "plugins.configs.mini-surround"
    end,
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.ai",
    config = function()
      require "plugins.configs.mini-ai"
    end,
    event = "VeryLazy",
  },
  {
    "otavioschwanck/arrow.nvim",
    config = function()
      require "plugins.configs.arrow"
    end,
    event = "VeryLazy",
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
    event = "VimEnter",
  },
  {
    "nat-418/boole.nvim",
    config = function()
      require "plugins.configs.boole"
    end,
    event = "VeryLazy",
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "plugins.configs.lualine"
    end,
    event = "VeryLazy",
  },
  {
    "vigoux/notifier.nvim",
    config = function()
      require("notifier").setup {
        -- You configuration here
      }
    end,
    event = "VeryLazy",
  },
  {
    "cappyzawa/trim.nvim",
    config = function()
      require "plugins.configs.trim"
    end,
    event = "BufWritePre",
  },
  {
    "TobinPalmer/rayso.nvim",
    cmd = "Rayso",
    config = function()
      require "plugins.configs.rayso"
    end,
  },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
    end,
  },
  {
    -- Lista de alterações de código uma especie de histórico para consultar depois
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    opts = {},
  },
  -- Tradutor de errors typescript
  {
    "dmmulroy/ts-error-translator.nvim",
    config = function()
      require "plugins.configs.ts-error-translator"
    end,
    event = "LspAttach",
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "nvim-telescope/telescope.nvim" }, -- apenas se quiser integrar com o Telescope
    event = "VeryLazy",
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    opts = {},
    keys = {
      {
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },
  {
    "y3owk1n/undo-glow.nvim",
    event = { "VeryLazy" },
    ---@type UndoGlow.Config
    opts = {
      animation = {
        enabled = true,
        duration = 300,
        animtion_type = "zoom",
        window_scoped = true,
      },
      highlights = {
        undo = {
          hl_color = { bg = "#693232" }, -- Dark muted red
        },
        redo = {
          hl_color = { bg = "#2F4640" }, -- Dark muted green
        },
        yank = {
          hl_color = { bg = "#7A683A" }, -- Dark muted yellow
        },
        paste = {
          hl_color = { bg = "#325B5B" }, -- Dark muted cyan
        },
        search = {
          hl_color = { bg = "#5C475C" }, -- Dark muted purple
        },
        comment = {
          hl_color = { bg = "#7A5A3D" }, -- Dark muted orange
        },
        cursor = {
          hl_color = { bg = "#793D54" }, -- Dark muted pink
        },
      },
      priority = 2048 * 3,
    },
    keys = {
      {
        "u",
        function()
          require("undo-glow").undo()
        end,
        mode = "n",
        desc = "Undo with highlight",
        noremap = true,
      },
      {
        "U",
        function()
          require("undo-glow").redo()
        end,
        mode = "n",
        desc = "Redo with highlight",
        noremap = true,
      },
      -- {
      --   "p",
      --   function()
      --     require("undo-glow").paste_below()
      --   end,
      --   mode = "n",
      --   desc = "Paste below with highlight",
      --   noremap = true,
      -- },
      -- {
      --   "P",
      --   function()
      --     require("undo-glow").paste_above()
      --   end,
      --   mode = "n",
      --   desc = "Paste above with highlight",
      --   noremap = true,
      -- },
      {
        "n",
        function()
          require("undo-glow").search_next {
            animation = {
              animation_type = "strobe",
            },
          }
        end,
        mode = "n",
        desc = "Search next with highlight",
        noremap = true,
      },
      {
        "N",
        function()
          require("undo-glow").search_prev {
            animation = {
              animation_type = "strobe",
            },
          }
        end,
        mode = "n",
        desc = "Search prev with highlight",
        noremap = true,
      },
      {
        "*",
        function()
          require("undo-glow").search_star {
            animation = {
              animation_type = "strobe",
            },
          }
        end,
        mode = "n",
        desc = "Search star with highlight",
        noremap = true,
      },
      {
        "#",
        function()
          require("undo-glow").search_hash {
            animation = {
              animation_type = "strobe",
            },
          }
        end,
        mode = "n",
        desc = "Search hash with highlight",
        noremap = true,
      },
      {
        "gc",
        function()
          -- This is an implementation to preserve the cursor position
          local pos = vim.fn.getpos "."
          vim.schedule(function()
            vim.fn.setpos(".", pos)
          end)
          return require("undo-glow").comment()
        end,
        mode = { "n", "x" },
        desc = "Toggle comment with highlight",
        expr = true,
        noremap = true,
      },
      {
        "gc",
        function()
          require("undo-glow").comment_textobject()
        end,
        mode = "o",
        desc = "Comment textobject with highlight",
        noremap = true,
      },
      {
        "gcc",
        function()
          return require("undo-glow").comment_line()
        end,
        mode = "n",
        desc = "Toggle comment line with highlight",
        expr = true,
        noremap = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight when yanking (copying) text",
        callback = function()
          require("undo-glow").yank()
        end,
      })

      -- This only handles neovim instance and do not highlight when switching panes in tmux
      vim.api.nvim_create_autocmd("CursorMoved", {
        desc = "Highlight when cursor moved significantly",
        callback = function()
          require("undo-glow").cursor_moved {
            animation = {
              animation_type = "slide",
            },
          }
        end,
      })

      vim.api.nvim_create_autocmd("CmdLineLeave", {
        pattern = { "/", "?" },
        desc = "Highlight when search cmdline leave",
        callback = function()
          require("undo-glow").search_cmd {
            animation = {
              animation_type = "fade",
            },
          }
        end,
      })
    end,
  },
  {
    "mawkler/jsx-element.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    ft = { "typescriptreact", "javascriptreact" },
    opts = {},
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    cmd = "Neotree",
  },
  {
    "stevearc/aerial.nvim",
    event = "BufReadPost",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}

require("lazy").setup(plugins, require "lazy_config")
