
" General options {{{
filetype plugin indent on

" custom colourscheme which allows for transparent background
colorscheme industry-max
set tabstop=4
set shiftwidth=4
set scrolloff=4
set lazyredraw
set ruler
set title
" case insensitive searches unless you use a capital letter
"set noignorecase
set smartcase
set infercase

" searches wrap around the end of the file
set wrapscan

set history=200
set showcmd

set nohlsearch
set incsearch

" Don't backup files matching this pattern
set backupskip=/tmp/*,*~
" Make copies of edited files when backing up, don't rename the original file
" as the backup and write a new one. This preserves the creation time of the
" file
set backupcopy=yes

" directory for backup file.
" Warning: there is a bug in nvim as of 21/06/20 where if backupcopy=yes and
" the first directory in backupdir does't exist, it will fail to write a backup
" even if a subsequent one (lower precedence) in the backupdir list does
" exist. So make sure the first directory exists!
"
set backupdir=~/.vimtemp,.
" directory for swap file
set dir=.,./.vimtemp,~/.vimtemp

" bell control
"set belloff=backspace,cursor,insertmode
set belloff=all

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

" }}}

" Mappings {{{
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
"nnoremap <C-h> B
"nnoremap <C-l> E

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
inoremap <C-BS> <C-W>


" save with WW
nnoremap WW :w<CR>

" Exit with Ctrl-D
nnoremap <C-D> :confirm quit<CR>

" ds to delete up to the next non space character, cs to change up to the next non-space char
nnoremap ds d/\S<CR>:nohlsearch<CR>
nnoremap cs d/\S<CR>:nohlsearch<CR>i

" screen centering
nnoremap <C-O> <C-O>zz
nnoremap n nzz
nnoremap N Nzz

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

" Command to replace fancy digraph quotes (“ and ”) with simple double quotes
if !exists(":Requote")
	command Requote %s/“\|”/"/g
endif

" pgsql syntax default for SQL files
let g:sql_type_default = 'pgsql'

" Latex Section {{{
let g:tex_flavor = 'latex'
let g:vimtex_enabled = 1


"nvim remote
let g:vimtex_compiler_progname = 'nvr'
"let g:vimtex_view_method = 'zathura'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'evince'
"syntax highlighting within minted environment
" if the syntax file is named something else, you can specify it here
" e.g. for python, it will look for 'syntax/python.vim'
" defaults to the value of 'lang'
let g:vimtex_syntax_minted = [
			\ {'lang': 'python', 'syntax' : 'python'},
			\ {'lang': 'sh', 'syntax' : 'sh'}
			\ ]
let g:vimtex_indent_enabled = 0

" stop filetype indent from adding an indent every time you type ( or } in an \align{...}
"let g:tex_indent_and = 0
" let g:vimtex_indent_delims = {
" 	  \ 'open' : ['{', '\\\@<!\\\['],
" 	  \ 'close' : ['}', '\\\]'],
" 	  \ 'include_modified_math' : 1,
" 	  \}
let g:vimtex_indent_delims = {
	  \ 'open' : [],
	  \ 'close' : [],
	  \ 'include_modified_math' : 0,
	  \}

" stop overfull hbox warnings
let g:vimtex_quickfix_ignore_filters = [
	  \ 'overfull hbox',
	  \ 'underfull hbox',
	  \]

" enable compilation on saving


" }}}

function CodingInit(width)
	setlocal expandtab tabstop=4 number linebreak
	let &l:textwidth=a:width
	" auto complete braces
	" TODO push closing delimiter onto a stack, and whenever a closing
	" delimeter is typed, ignore it if it's the one on the top
	" clear the stack when exiting insert mode
	"inoremap " ""<left>
	"inoremap ( ()<left>
	"inoremap [ []<left>
	"inoremap { {}<left>
	" make sure you can cancel out of it if presed by mistake
	"inoremap "<BS> <nop>
	"inoremap (<BS> <nop>
	"inoremap [<BS> <nop>
	"inoremap {<BS> <nop>
	" or just insert the opening delimeter if you want to
	"inoremap "<ESC> "
	"inoremap (<ESC> (
	"inoremap [<ESC> [
	"inoremap {<ESC> {
	" don't double insert the closing delimter
	"inoremap "" ""
	"inoremap () ()
	"inoremap [] []
	"inoremap {} {}
	" some tricky newline tricks
	inoremap {<CR> {<CR>}<ESC>O
	inoremap {;<CR> {<CR>};<ESC>O
endfunction

function TextInit()
	setlocal linebreak noet
	inoremap `p •<space>
	" pretty UTF-8 arrows
	"inoremap -><space> →<space>
	"inoremap <-<space> ←<space>
endfunction

function TexInit()
	setlocal colorcolumn=+0
	nnoremap \be i\begin{equation}<ESC>
endfunction

function DartInit()
	setlocal shiftwidth=2 tabstop=2
endfunction


" Filetype-specific settings and commands
augroup ftspecific
	autocmd! ftspecific
	autocmd FileType julia  	call CodingInit(95)
	autocmd FileType python 	call CodingInit(95)
	autocmd FileType dart   	call CodingInit(95)
	autocmd FileType dart   	call DartInit()
	" existing python scripts use tabs
	"autocmd FileType python 	setlocal noet
	autocmd FileType matlab 	call CodingInit(83)
	autocmd FileType matlab 	setlocal colorcolumn=+2,+3
	autocmd FileType tex 		call vimtex#init()
	" wrap text using newline chars at textwidth; draw a red bar there.
	autocmd FileType tex 		call CodingInit(80)
	autocmd FileType tex 		call TexInit()
	autocmd FileType text       call TextInit()
	"autocmd Filetype tex runtime after/syntax/tex.vim
	autocmd Filetype cpp 		call CodingInit(95)
	autocmd Filetype arduino 	call CodingInit(95)
	autocmd Filetype c 			call CodingInit(95)
	autocmd Filetype sql 		call CodingInit(95)
	autocmd Filetype java 		call CodingInit(95)
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
let g:R_term = "kitty"
let g:R_term_cmd = "kitty R"
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

" change to (absolute path of) directory containing file
" :help filename-modifiers
autocmd BufEnter * silent lcd %:p:h

" performance hack
au BufWinLeave * call clearmatches()

" vim: foldmethod=marker:foldlevel=0
