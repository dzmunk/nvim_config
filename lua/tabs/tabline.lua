local api = vim.api
local fn = vim.fn
local g = vim.g
local cur_buf = api.nvim_get_current_buf
local buf_name = api.nvim_buf_get_name

local M = {}

local function text(str, hl)
  str = str or ""
  local a = "%#Tb" .. hl .. "#" .. str
  return a
end

local function button(str, hl, func, arg)
  str = hl and text(str, hl) or str
  arg = arg or ""
  return "%" .. arg .. "@Tb" .. func .. "@" .. str .. "%X"
end

local order = { "treeOffset", "buffers", "tabs", "btns" }

local function available_space()
  local str = ""

  for _, key in ipairs(order) do
    if key ~= "buffers" then
      str = str .. M[key]()
    end
  end

  local modules = api.nvim_eval_statusline(str, { use_tabline = true })
  return vim.o.columns - modules.width
end

local function filename(str)
  return str:match "([^/\\]+)[/\\]*$"
end

local function gen_unique_name(oldname, index)
  for i, nr in ipairs(vim.t.bufs) do
    if index ~= i and filename(buf_name(nr)) == oldname then
      return fn.fnamemodify(buf_name(vim.t.bufs[index]), ":p:.")
    end
  end
end

local function style_buf(nr, i)
  local is_curbuf = cur_buf() == nr
  local name = filename(buf_name(nr))

  name = gen_unique_name(name, i) or name
  name = (name == "" or not name) and " No Name " or name

  -- tab max width 23 -> 17 name + 1 space + 2 close icon + 2 pad + 1 integer rounding
  local pad = math.floor((20 - #name) / 2)
  pad = pad <= 0 and 1 or pad

  name = string.sub(name, 1, 15) .. (#name > 17 and ".." or "")
  name = text(" " .. name, is_curbuf and "BufOn" or "BufOff")

  name = string.rep(" ", pad) .. name .. string.rep(" ", pad - 1)

  local close_button = button(" 󰅖 ", nil, "KillBuf", nr)
  name = button(name, nil, "GoToBuf", nr)

  -- modified close icon
  local mod = api.nvim_get_option_value("mod", { buf = nr })
  local cur_mod = api.nvim_get_option_value("mod", { buf = 0 })

  -- color close button for focused / hidden  buffers
  if is_curbuf then
    close_button = cur_mod and text("  ", "BufOnModified") or text(close_button, "BufOnClose")
  else
    close_button = mod and text("  ", "BufOffModified") or text(close_button, "BufOffClose")
  end

  name = text(name .. close_button, is_curbuf and "BufOn" or "BufOff")

  return name
end

local function getNvimTreeWidth()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
      return api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

vim.cmd "function! TbGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction"
vim.cmd [[
   function! TbKillBuf(bufnr,b,c,d) 
        call luaeval('require("tabs").close_buffer(_A)', a:bufnr)
  endfunction]]
vim.cmd "function! TbNewTab(a,b,c,d) \n tabnew \n endfunction"
vim.cmd "function! TbGotoTab(tabnr,b,c,d) \n execute a:tabnr ..'tabnext' \n endfunction"
vim.cmd "function! TbCloseAllBufs(a,b,c,d) \n lua require('tabs').closeAllBufs() \n endfunction"
vim.cmd "function! TbToggleTabs(a,b,c,d) \n let g:TbTabsToggled = !g:TbTabsToggled | redrawtabline \n endfunction"

M.treeOffset = function()
  return "%#NvimTreeNormal#" .. string.rep(" ", getNvimTreeWidth())
end

M.buffers = function()
  local buffers = {}
  local has_current = false

  for i, nr in ipairs(vim.t.bufs) do
    if ((#buffers + 1) * 23) > available_space() then
      if has_current then
        break
      end

      table.remove(buffers, 1)
    end

    has_current = cur_buf() == nr or has_current
    table.insert(buffers, style_buf(nr, i))
  end

  return table.concat(buffers) .. text("%=", "Fill") -- buffers + empty space
end

g.TbTabsToggled = 0

M.tabs = function()
  local result, tabs = "", fn.tabpagenr "$"

  if tabs > 1 then
    for nr = 1, tabs, 1 do
      local tab_hl = (nr == fn.tabpagenr()) and "TabOn" or "TabOff"
      result = result .. button(" " .. nr .. " ", tab_hl, "GotoTab", nr)
    end

    local new_tabtn = button("  ", "TabNewBtn", "NewTab")
    local tabstoggleBtn = button(" 󰅂 ", "TabTitle", "ToggleTabs")
    local small_btn = button(" 󰅁 ", "TabTitle", "ToggleTabs")

    return g.TbTabsToggled == 1 and small_btn or new_tabtn .. tabstoggleBtn .. result
  end

  return ""
end

M.btns = function()
  local closeAllBufs = button(" 󰅖 ", "CloseAllBufsBtn", "CloseAllBufs")
  return closeAllBufs
end


return function()
  local result = {}

  for _, v in ipairs(order) do
    table.insert(result, M[v]())
  end

  return table.concat(result)
end

