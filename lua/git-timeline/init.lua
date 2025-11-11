local M = {}

local preview_buf = nil  -- buffer único para preview
local preview_win = nil  -- janela onde o preview fica

local function git_cmd(cmd)
  local handle = io.popen(cmd)
  if not handle then return {} end
  local result = handle:read("*a")
  handle:close()
  return vim.split(result or "", "\n", { trimempty = true })
end

local function get_file_history(file)
  return git_cmd(string.format(
    [[git log --pretty=format:"%%h %%an - %%ad : %%s" --date=format:"%%d/%%m/%%Y %%H:%%M" --date-order -- %s]],
    file
  ))
end

local function get_file_version(hash, file)
  return git_cmd(string.format("git show %s:%s", hash, file))
end

local function open_in_preview(lines, filetype)
  -- se o preview não existe, cria split vertical
  if not (preview_buf and vim.api.nvim_buf_is_valid(preview_buf)) then
    vim.cmd("vsplit")
    preview_win = vim.api.nvim_get_current_win()
    preview_buf = vim.api.nvim_get_current_buf()
    vim.bo[preview_buf].buftype = "nofile"
    vim.bo[preview_buf].bufhidden = "wipe"
    vim.bo[preview_buf].modifiable = false
    vim.bo[preview_buf].readonly = true
  end

  -- coloca o preview na janela correta
  vim.api.nvim_set_current_buf(preview_buf)
  vim.bo[preview_buf].modifiable = true
  vim.api.nvim_buf_set_lines(preview_buf, 0, -1, false, lines)
  vim.bo[preview_buf].modifiable = false
  vim.bo[preview_buf].filetype = filetype or vim.bo.filetype
end

function M.show_history()
  local file = vim.fn.expand("%")
  local history = get_file_history(file)

  if vim.tbl_isempty(history) then
    vim.notify("Nenhum histórico encontrado para " .. file, vim.log.levels.WARN)
    return
  end

  -- popula quickfix
  vim.fn.setqflist({}, "r", {
    title = "Git History: " .. file,
    items = vim.tbl_map(function(line)
      return { text = line }
    end, history),
  })
  vim.cmd("copen")

  -- mapeia Enter no quickfix
  vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "", {
    noremap = true,
    callback = function()
      local qf_idx = vim.fn.line(".")
      local entry = history[qf_idx]
      if not entry then return end

      local hash = entry:match("^(%S+)")
      if not hash then return end

      local content = get_file_version(hash, file)
      local filetype = vim.bo.filetype  -- mantém highlight do arquivo original
      open_in_preview(content, filetype)
    end,
  })
end

return M
