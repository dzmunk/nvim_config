-- plugins/bufferline.lua
local M = {}

function M.setup()
  require('bufferline').setup {
    options = {
      close_command = function(bufnum) M.bufremove(bufnum) end,
      right_mouse_command = "bdelete! %d",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
          separator = true
        }
      },
      always_show_bufferline = false,
    }
  }
end

function M.bufremove(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  -- Prompt to save if there are unsaved changes
  if vim.bo[buf].modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname(buf)), "&Yes\n&No\n&Cancel")
    if choice == 0 or choice == 3 then -- Cancel or <Esc>
      return
    end
    if choice == 1 then -- Yes
      vim.cmd("write")
    end
  end

  -- Manage windows displaying the buffer
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Use alternate buffer if available and listed
      local alt = vim.fn.bufnr("#")
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Use previous buffer if available
      local has_previous = pcall(vim.cmd, "bprevious")
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Otherwise, create and set a new buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end

  -- Delete the buffer if it’s still valid
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, "bdelete! " .. buf)
  end
end

return M
