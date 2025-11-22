local map = vim.keymap.set
local default_opts = { noremap = true }

local functions = require "functions"

vim.g.mapleader = " "

map("n", "<C-s>", functions.switch_case, default_opts)

-- Motion windows
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- neotree
map("n", "<leader>e", "<cmd> Neotree toggle <CR>")
map("n", "<C-f>", "<cmd> Neotree reveal <CR>")

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
map("n", "<S-p>", "<cmd> BufferLineTogglePin <CR>")
map("n", "<S-q>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype

  if filetype == "neo-tree" then
    vim.notify "Não é possível fechar o buffer do Neo-Tree"
    return
  end

  local buffers = vim.tbl_filter(function(b)
    return vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted and b ~= bufnr
  end, vim.api.nvim_list_bufs())

  if #buffers > 0 then
    vim.cmd("buffer " .. buffers[1])
  end

  vim.api.nvim_buf_delete(bufnr, { force = false })
end)

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
map({ "n", "v" }, "S", "<cmd> HopChar1 <CR>", { noremap = true, silent = true })
map({ "n", "v" }, "f", "<cmd> HopChar1CurrentLine <CR>", { noremap = true, silent = true })

-- Todo comments
map("n", "tl", "<cmd> TodoTelescope <CR>")

-- Atone
map("n", "<leader>u", "<cmd> Atone toggle <CR>", { noremap = true, silent = true })

-- (Scissor) criar snippets e editar em tempo real
map("n", "<leader>sa", function()
  require("scissors").addNewSnippet()
end, { desc = "Snippet: Add" })
map("n", "<leader>se", function()
  require("scissors").editSnippet()
end, { desc = "Snippet: Edit" })
