vim.api.nvim_create_user_command("FixImports", function()
  local buf = vim.api.nvim_get_current_buf()
  local fname = vim.api.nvim_buf_get_name(buf)

  vim.lsp.buf.execute_command {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(buf) },
  }

  -- 2️⃣ Espera um pouco para garantir que LSP terminou
  vim.defer_fn(function()
    -- 3️⃣ Roda ESLint --fix
    vim.fn.jobstart({ "npx", "eslint", "--fix", fname }, {
      on_exit = function(_, code, _)
        if code == 0 then
          vim.schedule(function()
            vim.notify("Imports organizados e ESLint aplicado!", vim.log.levels.INFO)
          end)
        else
          vim.schedule(function()
            vim.notify("Erro ao rodar ESLint", vim.log.levels.ERROR)
          end)
        end
      end,
    })
  end, 200) -- espera 200ms
end, { desc = "Organize imports + fix eslint" })

vim.api.nvim_create_user_command("GitTimeline", function()
  require("git-timeline").show_history()
end, {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.tsx", "*.jsx", "*.json" },
  callback = function(args)
    vim.lsp.buf.format({ async = false })
  end,
})

-- Auto-run Biome on save if biome.json exists
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*",
--   callback = function()
--     -- Encontra o root do projeto
--     local root = vim.fn.findfile("biome.json", ".;")
--     if root ~= "" then
--       -- Roda o Biome para o arquivo atual
--       local file = vim.fn.expand("%:p")
--       vim.fn.jobstart({ "biome", "check", "--write", "--unsafe", file }, {
--         stdout_buffered = true,
--         stderr_buffered = true,
--       })
--     end
--   end,
-- })

-- mason, write correct names only
vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd "MasonInstall css-lsp html-lsp lua-language-server typescript-language-server stylua prettier tailwindcss-language-server emmet-language-server pyright black"
end, {})

vim.api.nvim_create_user_command("TSInstallAll", function()
  vim.cmd "TSInstall css yaml xml tsx json html lua javascript typescript markdown python"
end, {})

vim.api.nvim_create_user_command("S", function()
  vim.cmd "source %"
end, {})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = false }),
  pattern = {
    "PlenaryTestPopup",
    "grug-far",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns.blame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = false }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = false }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", { clear = false }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("man_unlisted", { clear = false }),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("json_conceal", { clear = false }),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
