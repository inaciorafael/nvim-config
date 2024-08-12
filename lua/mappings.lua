local map = vim.keymap.set
local default_opts = { noremap = true }

local functions = require('functions')

vim.g.mapleader = " "

map('n', '<C-s>', functions.switch_case, default_opts)

-- general mappings
-- map("n", "<C-s>", "<cmd> w <CR>")
-- map("i", "jk", "<ESC>")
-- map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent

-- Motion windows
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- nvimtree
map("n", "<leader>e", "<cmd> NvimTreeToggle <CR>")
map("n", "<C-f>", "<cmd> NvimTreeFindFile <CR>")

-- telescope
local function find_files()
  -- require("telescope.builtin").find_files { cwd = vim.fn.getcwd() }
  require("telescope.builtin").find_files { find_command = { "rg", "--files", "--hidden", "-g", "!.git" } }
end

local function live_grep()
  require("telescope.builtin").live_grep { cwd = vim.fn.getcwd() }
end

map("n", "<leader>ff", find_files)
map("n", "<leader>fb", "<cmd> Telescope buffers <cr>", default_opts)
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fw", live_grep)
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
map("n", "<leader>fp", "<cmd> Telescope projects <CR>")
map("n", "<leader>lw", "<cmd> Telescope diagnostics <CR>")

-- bufferline, cycle buffers
map("n", "<S-l>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-h>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<S-q>", "<cmd> Bdelete <CR>")
map("n", "<S-p>", "<cmd> BufferLineTogglePin <CR>")

-- comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })

-- format
map("n", "<leader>cf", function()
  require("conform").format()
end)

-- Oil
map("n", "-", "<cmd> Oil <CR>", { desc = "Open parent directory" })

-- Hop
map("n", "S", "<cmd> HopChar1 <CR>", { noremap = true, silent = true })
map("n", "W", "<cmd> HopChar1CurrentLine <CR>", default_opts)

-- Todo comments
map("n", "tl", "<cmd> TodoTelescope <CR>")

-- Undotree
-- Verificar se o NvimTree está visível
local function is_nvim_tree_open()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match "NvimTree_1" then
      return true
    end
  end

  return false
end

local function open_undotree()
  if is_nvim_tree_open() then
    vim.cmd "NvimTreeClose"
  end

  vim.cmd "UndotreeToggle"
end

map("n", "<leader>u", open_undotree, { noremap = true, silent = true })
