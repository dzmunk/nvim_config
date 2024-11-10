-- Function to check if the current directory is a Git repository
local function is_git_repo()
  local git_dir = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';')
  return git_dir ~= nil and #git_dir > 0
end

-- Function to get the Git branch name
local git_branch = ''
local function update_git_branch()
  if is_git_repo() then
    local handle = io.popen('git -C "' .. vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':h') .. '" branch --show-current 2>/dev/null')
    if handle then
      local branch_name = handle:read("*a"):gsub("\n", "")
      handle:close()
      if branch_name ~= '' then
        git_branch = '  ' .. branch_name .. ' '
      else
        git_branch = ''
      end
    end
  else
    git_branch = ''
  end
end

-- Expose git_branch to the global namespace
_G.git_branch = function()
  return git_branch
end

-- Create autocommand to update Git branch on relevant events
vim.api.nvim_create_autocmd(
  {"BufEnter", "FocusGained", "ShellCmdPost"},
  { callback = update_git_branch }
)

-- Function to get the current mode
local function mode()
  local modes = {
    ['n']  = 'NORMAL',
    ['no'] = 'O-PENDING',
    ['v']  = 'VISUAL',
    ['V']  = 'V-LINE',
    [''] = 'V-BLOCK', -- Ctrl-v in terminal
    ['i']  = 'INSERT',
    ['ic'] = 'INSERT',
    ['R']  = 'REPLACE',
    ['Rv'] = 'V-REPLACE',
    ['c']  = 'COMMAND',
    ['cv'] = 'COMMAND',
    ['ce'] = 'COMMAND',
    ['r']  = 'PROMPT',
    ['rm'] = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!']  = 'SHELL',
    ['t']  = 'TERMINAL',
  }
  local m = vim.api.nvim_get_mode().mode
  return modes[m] or 'UNKNOWN'
end

-- Expose the mode function for use in v:lua
_G.mode = mode

-- Function to get the file path or CWD if no file is open
local function file_or_cwd()
  local bufname = vim.fn.bufname('%')
  if bufname == '' then
    return vim.fn.getcwd() -- Return the current working directory
  else
    return bufname -- Return the file path
  end
end

-- Expose file_or_cwd for use in v:lua
_G.file_or_cwd = file_or_cwd

-- Function to get the file encoding
local function file_encoding()
  local encoding = vim.bo.fenc ~= '' and vim.bo.fenc or vim.o.enc -- File or default encoding
  return encoding
end

-- Expose file_encoding for use in v:lua
_G.file_encoding = file_encoding

-- Function to get line ending type
local function line_ending()
  local endings = {
    ['unix'] = 'LF',
    ['dos'] = 'CRLF',
    ['mac'] = 'CR'
  }
  return endings[vim.bo.fileformat] or vim.bo.fileformat
end

-- Expose line_ending for use in v:lua
_G.line_ending = line_ending

-- Set the statusline
vim.o.statusline = table.concat({
  "%#TbTabCloseBtn# %{v:lua.mode()} ",             -- Mode
  "%#TbBufOn# %{v:lua.file_or_cwd()} ",      -- File path or CWD
  "%m ",                                     -- Modified flag
  "%r ",                                     -- Readonly flag
  "%#TbBufOnModified# %{v:lua.git_branch()} ", -- Git branch
  "%=",                                      -- Align right
  "%#TbBufOff# %y[%{v:lua.file_encoding()}|%{v:lua.line_ending()}] ", -- File type, encoding, and line ending
  "Ln %l/%L, Col %c ",                       -- Line and column
  "%#TbTabCloseBtn# [%p%%]"                -- Percentage
})
