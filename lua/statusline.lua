local M = {}

local have_nerd_font = true

local icons = have_nerd_font and {
    sep_left   = '',
    sep_right  = '',
    git        = '',
} or {
    sep_left   = '[',
    sep_right  = ']',
    git        = 'git:',
}

local mode_names = {
    n   = 'NORMAL',  
    no  = 'O-PEND',
    v   = 'VISUAL',  
    V   = 'V-LINE', 
    ['\22'] = 'V-BLOCK',
    i   = 'INSERT',  
    R   = 'REPLACE',
    c   = 'CMD',     
    s   = 'SELECT', 
    S = 'SELECT', 
    ['\19'] = 'SELECT',
    t   = 'TERM',
}

local function mode_component()
    local m = vim.api.nvim_get_mode().mode
    local name = mode_names[m] or 'UNKNOWN'
    return ('%%#StatusLine#%s%s %s %s'):format(icons.sep_left, '%#StatusLine#', name, icons.sep_right)
end

local function file_component()
    local name = vim.api.nvim_buf_get_name(0)
    if name == '' then return '[No Name]' end
    return vim.fn.fnamemodify(name, ':.')
end

local function flags_component()
    local parts = {}
    if vim.bo.modified then table.insert(parts, ' (+)') end
    if not vim.bo.modifiable or vim.bo.readonly then table.insert(parts, ' (Read Only)') end
    return table.concat(parts, ' ')
end

local git_cache = {}
local function buf_dir()
    local name = vim.api.nvim_buf_get_name(0)
    return name ~= '' and vim.fn.fnamemodify(name, ':h') or vim.uv.cwd()
end

local function update_git_branch()
    local dir = buf_dir()
    if not dir or dir == '' then return end
    local root = vim.fs.root(0, '.git')
    if not root or root == '' then
        git_cache[dir] = nil
        return
    end
    vim.system({ 'git', '-C', root, 'branch', '--show-current' }, { text = true }, function(res)
        local out = (res.stdout or ''):gsub('%s+$', '')
        git_cache[dir] = (out ~= '') and out or nil
        vim.schedule(vim.cmd.redrawstatus)
    end)
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
    group = vim.api.nvim_create_augroup('statusline_git', { clear = true }),
    callback = update_git_branch,
})

local function git_component()
    local dir = buf_dir()
    local branch = dir and git_cache[dir] or nil
    if not branch or branch == '' then return '' end
    return ('%s %s'):format(icons.git, branch)
end

local function diagnostics_component()
    return vim.diagnostic.status() or ''
end

local function fileinfo_component()
    local ft = (vim.bo.filetype ~= '' and vim.bo.filetype) or 'none'
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    local eol = ({ unix = 'LF', dos = 'CRLF', mac = 'CR' })[vim.bo.fileformat] or vim.bo.fileformat
    return ('%s  [%s|%s]'):format(ft, enc, eol)
end

local function position_component()
    return 'Ln %l/%L, Col %c  [%p%%]'
end

local lsp_progress = nil
vim.api.nvim_create_autocmd({ "LspProgress", "DiagnosticChanged" }, {
    group = vim.api.nvim_create_augroup("statusline_lsp", { clear = true }),
    callback = function(args)
        if args.event == "LspProgress" and args.data then
            local v = args.data.params.value
            if v.kind == "end" then
                lsp_progress = nil
                vim.defer_fn(function() vim.cmd.redrawstatus() end, 500)
            else
                lsp_progress = v.title or "LSP"
                vim.cmd.redrawstatus()
            end
        else
            vim.cmd.redrawstatus()
        end
    end,
})

local function lsp_component()
    return lsp_progress and ("LSP: " .. lsp_progress) or ""
end

function M.render()
    local left = table.concat({
        mode_component(),
        ' ',
        file_component(),
        '',
        flags_component(),
        '   ',
        git_component(),
        '   ',
        lsp_component(),
    })

    local right = table.concat({
        diagnostics_component(),
        '   ',
        fileinfo_component(),
        '   ',
        position_component(),
    })

    return table.concat({ left, '%=', right, ' ' })
end

vim.o.statusline = "%!v:lua.require'statusline'.render()"
return M
