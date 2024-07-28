local map = vim.keymap.set
vim.g.mapleader = " "

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
-- map("i", "jk", "<ESC>")
-- map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent

-- Motion windows
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- nvimtree
map("n", "<leader>e", "<cmd> NvimTreeToggle <CR>")
-- map("n", "<C-h>", "<cmd> NvimTreeFocus <CR>")

-- telescope
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
map("n", "<leader>lw", "<cmd> Telescope diagnostics <CR>")
map("n", "<leader>lp", "<cmd> Telescope projects <CR>")

-- bufferline, cycle buffers
map("n", "<S-l>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-h>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<S-q>", "<cmd> bd <CR>")
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

-- Todo comments
map("n", "tl", "<cmd> TodoTelescope <CR>")

-- Session
-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)

-- select a session to load
vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)

-- load the last session
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)
