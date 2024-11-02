local M = {}
local api = vim.api
local fn = vim.fn

-- Maintain a list of listed buffers in each tab
vim.t.bufs = vim.t.bufs or {}

-- Cache for last tabline to prevent unnecessary redraws
local last_tabline = nil

-- Update buffer list to include only listed buffers
local function update_buf_list()
  vim.t.bufs = vim.tbl_filter(function(bufnr)
    return vim.bo[bufnr].buflisted
  end, api.nvim_list_bufs())
end

-- Get the current buffer's index in the buffer list
local function buf_index(bufnr)
  for i, buf in ipairs(vim.t.bufs) do
    if buf == bufnr then
      return i
    end
  end
end

-- Get NvimTree width for offset if open
local function get_nvim_tree_width()
  for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
    local buf = api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "NvimTree" then
      return api.nvim_win_get_width(win)
    end
  end
  return 0
end

-- Navigate to the next buffer
function M.next_buffer()
  local current_buf = api.nvim_get_current_buf()
  local index = buf_index(current_buf)
  if index then
    local next_buf = vim.t.bufs[(index % #vim.t.bufs) + 1]
    api.nvim_set_current_buf(next_buf)
  end
end

-- Navigate to the previous buffer
function M.prev_buffer()
  local current_buf = api.nvim_get_current_buf()
  local index = buf_index(current_buf)
  if index then
    local prev_buf = vim.t.bufs[(index - 2) % #vim.t.bufs + 1]
    api.nvim_set_current_buf(prev_buf)
  end
end

-- Close the current buffer
function M.close_buffer(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  if vim.bo[bufnr].buflisted then
    vim.cmd("bdelete " .. bufnr)
    update_buf_list()
  end
end

-- Close all buffers except the current one
function M.close_other_buffers()
  local current_buf = api.nvim_get_current_buf()
  for _, buf in ipairs(vim.t.bufs) do
    if buf ~= current_buf then
      M.close_buffer(buf)
    end
  end
end

-- Close all buffers
function M.close_all_buffers()
  for _, buf in ipairs(vim.t.bufs) do
    M.close_buffer(buf)
  end
end

-- Move the current buffer within the buffer list
function M.move_buf(direction)
  local current_buf = api.nvim_get_current_buf()
  local index = buf_index(current_buf)
  if index then
    local swap_index = (index + direction - 1) % #vim.t.bufs + 1
    vim.t.bufs[index], vim.t.bufs[swap_index] = vim.t.bufs[swap_index], vim.t.bufs[index]
    api.nvim_set_current_buf(current_buf)
  end
end

-- Open a new buffer only if no unsaved buffer exists
function M.open_new_buffer()
  for _, buf in ipairs(vim.t.bufs) do
    if vim.bo[buf].buflisted and fn.bufname(buf) == "" and not vim.bo[buf].modified then
      api.nvim_set_current_buf(buf)
      return
    end
  end
  vim.cmd("enew")
  update_buf_list()
end

-- Function to generate the tabline with clickable tabs
function M.tabline()
  local s = ""
  local current_buf = api.nvim_get_current_buf()
  local nvim_tree_width = get_nvim_tree_width()

  -- Add padding for NvimTree if open
  if nvim_tree_width > 0 then
    s = s .. "%#TabLineFill#" .. string.rep(" ", nvim_tree_width)
  end

  -- Iterate through each buffer and add clickable tabs
  for _, buf in ipairs(vim.t.bufs) do
    local bufname = fn.fnamemodify(api.nvim_buf_get_name(buf), ":t")
    bufname = bufname == "" and "[No Name]" or bufname
    local highlight = (buf == current_buf) and "%#TabLineSel#" or "%#TabLine#"

    -- Make each tab clickable, ending with %T for each
    s = s .. "%" .. buf .. "@v:lua.TablineSwitchBuffer@" .. highlight .. " " .. bufname .. " %T"
  end

  s = s .. "%#TabLineFill#" -- Fill the rest of the tabline

  -- Check if the new tabline differs from the last one
  if s ~= last_tabline then
    last_tabline = s
    return s
  end
end

-- Global function to switch buffer when tab is clicked
_G.TablineSwitchBuffer = function(minwid, clicks, button, modifiers)
  local bufnr = tonumber(minwid)
  if bufnr and api.nvim_buf_is_valid(bufnr) then
    api.nvim_set_current_buf(bufnr)
  end
end

-- Enable the custom tabline
vim.o.tabline = "%!v:lua.require('tabs').tabline()"
vim.o.showtabline = 2 -- Always show the tabline
vim.o.mouse = "a" -- Enable mouse support for clickable tabs

-- Auto update buffer list on buffer-related events
api.nvim_create_autocmd({ "BufAdd", "BufEnter", "BufDelete" }, {
  callback = update_buf_list,
})

-- Key mappings for buffer management
vim.keymap.set("n", "<Tab>", ":lua require('tabs').next_buffer()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":lua require('tabs').prev_buffer()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", ":lua require('tabs').close_buffer()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bo", ":lua require('tabs').close_other_buffers()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ba", ":lua require('tabs').close_all_buffers()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bn", ":lua require('tabs').open_new_buffer()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tm", ":lua require('tabs').move_buf(1)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tM", ":lua require('tabs').move_buf(-1)<CR>", { noremap = true, silent = true })

-- Initialize buffer list
update_buf_list()

return M

