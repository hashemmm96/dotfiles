local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

augroup('Meson', { clear = true })
autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'Meson',
  pattern = 'meson.build',
  command = 'set filetype=meson',
})

autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'Meson',
  pattern = 'meson_options.txt',
  command = 'set filetype=mesonopt',
})
