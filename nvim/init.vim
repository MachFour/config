
" General options {{{
syntax on
colorscheme industry
set tabstop=4
set shiftwidth=4
set scrolloff=4
set lazyredraw
set ruler
set title
" case insensitive searches unless you use a capital letter
"set noignorecase
"set smartcase

" searches wrap around the end of the file
set wrapscan

set history=200
set showcmd

" Don't backup files matching this pattern
set backupskip=/tmp/*,*~
" directory for backup file
set backupdir=./.vimtemp,~/.vimtemp,.
" directory for swap file
set dir=.,./.vimtemp,~/.vimtemp

" bell control
set belloff=backspace,cursor,insertmode

" mouse control except in insert mode
if has("mouse")
	set mouse=nvh
endif

" allow backspacing over everything in insert mode
set backspace=eol,start,indent

set listchars=tab:→\ ,trail:·,nbsp:·
"
" window options
" prevent other windows from being resized when one is opened or closed.
" See also the winfixheight and winfixwidth options.
set noequalalways

set runtimepath+=/usr/share/vim/vimfiles

filetype plugin indent on

" }}}

" Mappings {{{jjjjjjjjjjjjjjjj
" stops arrow keys
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>

" make j,k move by screen line rather than file line,
" in normal, visual and operator-pending modes
noremap j gj
noremap k gk

"navigate in WORDS only
nnoremap w W
nnoremap b B
nnoremap e E
" Make H and L move the cursor to the start and end of the current line,
" not the top and bottom of the screen - in Normal, Visual and Operator-pending modes
noremap H ^
noremap L $
"navigate among WORDS using ctrl-b, ctrl-e? -> or leader
nnoremap <C-h> B
nnoremap <C-l> E

"up and down with ctrl-j, k
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
" make buffer windows easier to navigate
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" use Y to yank to end of line
nnoremap Y y$

" Map Ctrl-Backspace to delete the previous word in insert mode.
inoremap  <C-W>

" save with WW
nnoremap WW :w<CR>

" Exit with Ctrl-D
nnoremap <C-D> :confirm quit<CR>

" ds to delete up to the next non space character, cs to change up to the next non-space char
nnoremap ds d/\S<CR>:nohlsearch<CR>
nnoremap cs d/\S<CR>:nohlsearch<CR>i

nnoremap <C-N> :!make<CR>

" Sudo save trick
cmap w!! w !sudo tee > /dev/null %

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" leave cursor after pasted text
nnoremap p gp

" }}}

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

" pgsql syntax default for SQL files
let g:sql_type_default = 'pgsql'

" Latex Section {{{
let g:tex_flavor = 'latex'
let g:vimtex_enabled = 1


"nvim remote
let g:vimtex_latexmk_progname = 'nvr'
let g:vimtex_view_general_viewer = 'zathura'
"syntax hilighting within minted environment
" if the syntax file is named something else, you can specify it here
" e.g. for python, it will look for 'syntax/python.vim'
" defaults to the value of 'lang'
let g:vimtex_syntax_minted = [
			\ {'lang': 'python', 'syntax' : 'python'},
			\ {'lang': 'sh', 'syntax' : 'sh'}
			\ ]


"let g:tex_flavor="latex"
" stop filetype indent from adding an indent every time you type ( or } in an \align{...}
let g:tex_indent_and = 0
" enable compilation on saving


" }}}


" Filetype-specific settings and commands
augroup ftspecific
	autocmd! ftspecific
	autocmd FileType python 	setlocal noexpandtab tabstop=4 textwidth=79 number
	autocmd FileType matlab 	setlocal textwidth=83 colorcolumn=+2,+3 noexpandtab number
	autocmd FileType tex 		call vimtex#init()
	" wrap text using newline chars at textwidth; draw a red bar there.
	autocmd FileType tex 		setlocal textwidth=79 colorcolumn=+0
	autocmd FileType text 		setlocal linebreak
	"autocmd Filetype tex runtime after/syntax/tex.vim
	autocmd Filetype cpp 		setlocal textwidth=79 number
	autocmd Filetype arduino 	setlocal textwidth=79 number
	autocmd Filetype c 			setlocal textwidth=79 number
	autocmd Filetype sql 		setlocal textwidth=79 number
augroup END

" statusline examples
" %1*, %2*, etc. indicates User1, User2, etc. highlighting styles
" %0* or %* is reset
set statusline =
set statusline +=%1*\ %0*
set statusline +=%1*%f%q\ %0* 			"relative path or e.g. 'Quickfix List'
set statusline +=%1*%y%0* 				"file type
set statusline +=%1*%r%m%0* 			"readonly, modified flags
set statusline +=%1*\ \ %0*
set statusline +=%1*%=%0* 				"expanding separator
set statusline +=%1*\ \ %0*
"set statusline +=%1*%{&ff}\ %0* 		"file format
set statusline +=%1*col\ %02v\ %0* 		"virtual column number. Char code- just use ga
set statusline +=%1*%<line\ %0l/%L%0* 	"current line/total lines
set statusline +=%1*\ %0*

highlight User1 term=inverse,bold,italic cterm=bold ctermfg=White ctermbg=DarkGrey

"set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P
"statusline=%t%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''} %=%-15(%l,%c%V%) %P

highlight ColorColumn term=inverse ctermbg=DarkGrey


" {{{ syntastic options
"let g:syntastic_tex_lacheck_option = 'argument'
"let g:syntastic_tex_lacheck_quiet_messages = {"level": "errors"}
"let g:syntastic_tex_chktex_quiet_messages = {"level": "warning", "type": "style"}

" Add the syntastic function to Vim's statusline
if exists("loaded_syntastic_plugin")
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
endif

" Format string for the info produced by Syntastic (not Vim syntax)
let g:syntastic_stl_format = "[syntax: %E{%e err - %fe}%B{, }%W{%w warn - %fw}]"

" Fill Vim's location/quickfix window automatically.
" if 0, have to use :Errors to see the errors
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" column on left indicating error lines
let g:syntastic_enable_signs = 0

"let g:syntastic_matlab_mlint_arge

let g:syntastic_mode_map = {
			\ "mode" : "active",
			\ "active_filetypes": ["python", "matlab", "c", "cpp", "java"],
			\ "passive_filetypes": ["tex"] }
"let g:syntastic_quiet_messages = {
"		\ "!level":  "errors",
"		\ "type":    "style",
"		\ "regex":   '\m\[C03\d\d\]',
"		\ "file:p":  ['\m^/usr/include/', '\m\c\.h$'] }

" }}}

" supertab options {{{
" stop completion after various comment characters
let g:SuperTabNoCompleteAfter = ['^', '\s', '#', '"', '/', '%', ',', ';']
" }}}

" nvim-R options {{{
let g:R_assign = 0
let g:R_term = "termite"
let g:R_term_cmd = "termite-R"
let g:R_in_buffer = 0
" }}}

let g:highlight_whitespace = 1
" from https://github.com/jcs/dotfiles/blob/master/.vimrc

if g:highlight_whitespace
	" highlight stray spaces and tabs when out of insert mode
	hi ExtraWhitespace cterm=reverse ctermfg=185	ctermbg=NONE

	" match ExtraWhitespace /\s\+$/
	augroup whitespacematch
		autocmd! whitespacematch
		autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
		autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
		autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	augroup END
endif

autocmd BufEnter * silent lcd %:p:h

" performance hack
if version >= 702
	au BufWinLeave * call clearmatches()
endif

" vim: foldmethod=marker:foldlevel=0
