-- Set the package.path for plugins configuration
package.path = vim.fn.stdpath("config") .. "/lua/plugins/configs/?.lua;" .. package.path
package.path = vim.fn.stdpath("config") .. "/lua/plugins/configs/?/init.lua;" .. package.path

-- Set basic VIM configs
require("core.options")
require("core.keymaps")

-- Bootstrap Lazy.nvim
require("core.lazy")

-- Initialize plugins
require("plugins")

vim.opt.wrap = false
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

vim.o.clipboard = 'unnamedplus'
vim.api.nvim_exec([[
  augroup YankToClipboard
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('pbcopy', @0) | endif
  augroup END
]], false)


vim.cmd [[
augroup highlight_keywords
  autocmd!
  autocmd BufReadPost * call matchadd('Todo', '\[ip\]')
  autocmd BufReadPost * call matchadd('Visual', '\[done\]')
  autocmd BufReadPost * call matchadd('Error', '\[best\]')
augroup END
]]

vim.api.nvim_set_keymap('n', '<leader>lcd', ':lcd %:p:h<CR>', { noremap = true, silent = true })

-- Define a function to generate the tabline
function MyTabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    -- Switch to the tab to get the buffer name
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufname = vim.fn.bufname(buflist[winnr])
    -- Extract the file name without the path
    local filename = vim.fn.fnamemodify(bufname, ':t')
    -- Highlight the active tab
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    -- Add the tab number and file name
    s = s .. '%' .. i .. 'T' .. i .. ': ' .. filename .. ' '
  end
  s = s .. '%#TabLineFill#%T'
  return s
end
vim.o.tabline = '%!v:lua.MyTabline()'

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local buf_path = vim.fn.expand("%:p:h")
    vim.cmd("silent! lcd " .. buf_path)
  end,
})

-- Auto-save on InsertLeave and TextChanged
vim.cmd([[
  augroup AutoSave
    autocmd!
    autocmd InsertLeave,TextChanged * silent! if &modifiable && getbufvar('', '&buftype') == '' | update | endif
  augroup END
]])



