nnoremap <buffer> <silent> dd
  \ <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')<CR>
