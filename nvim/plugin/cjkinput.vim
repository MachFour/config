" adapted from https://github.com/dsewnr/linux-kitty-vim-cjk-input-tool/
" Need to have Zenity installed
"
function CJKInput()
    let l:cmd = 'zenity --entry --text=CJK-Input'
    let l:output = system(l:cmd)
    let l:output = substitute(l:output, '[\r\n]*$', '', '')
    execute 'normal i' . l:output
endfunction
nmap <silent> <leader>j :call CJKInput()<CR>
