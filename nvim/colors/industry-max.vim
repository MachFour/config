" Copied from industry colour scheme
" Modified to allow transparent background and colour tweaks

set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "industry-max"

" First set Normal to regular white on black text colors:
" hi Normal ctermfg=LightGray ctermbg=Black guifg=#dddddd   guibg=Black
hi Normal ctermfg=LightGray ctermbg=NONE guifg=#dddddd      guibg=NONE

" Syntax highlighting (other color-groups using default, see :help group-name):
hi Comment    cterm=NONE ctermfg=Blue           gui=NONE guifg=#00aaaa
hi Constant   cterm=NONE ctermfg=LightCyan      gui=NONE guifg=#00ffff
hi Identifier cterm=NONE ctermfg=LightMagenta   gui=NONE guifg=#ff00ff
hi Function   cterm=NONE ctermfg=LightGreen     gui=NONE guifg=#00ff00
hi Statement  cterm=NONE ctermfg=White          gui=bold guifg=#ffffff
hi PreProc    cterm=NONE ctermfg=Yellow         gui=NONE guifg=#ffff00
hi Type       cterm=NONE ctermfg=LightGreen     gui=bold guifg=#00ff00
hi Special    cterm=NONE ctermfg=LightRed       gui=NONE guifg=#ff0000
hi Delimiter  cterm=NONE ctermfg=Yellow         gui=NONE guifg=#ffff00

