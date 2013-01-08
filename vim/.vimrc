" VIM options {{{
" =============================================================================

" First up, this isn't vi
set nocompatible

" Clear existing autocomands
autocmd!

" Startup tweaks
filetype off

" Pathogen paths
call pathogen#infect()
call pathogen#infect('unmanaged')
call pathogen#helptags()

" Vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

source ~/.vim/plugins

syntax on
filetype plugin indent on
syntax enable

let mapleader="," " Cause \ is a bitch, yo
let maplocalleader="\\"

call togglebg#map("<F5>")

" Terminal Settings
" set t_Co=256 " GNOME Terminal doesn't present as 256 colours, this forces it
" set t_Co=16  " If using solarized as a terminal theme
set title    " Makes the terminal title reflect current buffer
set ttyfast  " Mark this as a fast terminal

colorscheme Peacock
" set background=dark

" GUI settings
if has("gui_running")
	set guioptions=aegi
	set linespace=3 " bump this up a little bit for looks
endif

" OS GUI Settings
if has("gui_macvim")
	set guifont=Source\ Code\ Pro:h12
	set fuoptions=maxvert,maxhorz
	set columns=110
	set shell=/bin/zsh
elseif has("gui_win32")
	set guifont=Droid\ Sans\ Mono:h12
elseif has("gui_gtk")
	set guifont=Ubuntu\ Mono\ 12
endif

" Makes the colorcolumn a different colour, useful with certain schemes
" hi ColorColumn guibg=#404040

" Good for powerline
hi ColorColumn guibg=#303030

" Core VIM Settings
set hidden        " Hides buffers rather than require they be written out
set laststatus=2  " Defines when VIM draws the status line (2=always)
set modelines=0   " Never read any modelines (security weakness)
set nobackup
set noerrorbells
set noswapfile    " Swap files cause more annoyance than they're worth
set novisualbell
set nowritebackup
set autoread      " Automatically read files into the buffer if they've changed
				  " on disk. Relatively safe given the `FocusLost wall`
				  " autocommand
set shortmess=atI " Skip those annoying 'Press Enter' messages
				  " http://items.sjbach.com/319/configuring-vim-right

" Wildcard matching
set wildignore=*.swp,*.bak,*.pyc,*.class,node_modules/*,_sgbak,.DS_Store
set wildmenu
set wildmode=longest,list:longest

" Search Optimizations
set hlsearch
set ignorecase
set incsearch " Incremental search as you type
set smartcase " Use case sensitivity if search includes a capital letter

" Editor Settings

" Sets file encoding to UTF-8 for new files
if !strlen(&fileencoding)
	set fileencoding=utf-8
endif

set autoindent
set backspace=indent,eol,start " I don't use Windows much anymore, but this fixes the backspace key for it
set clipboard=unnamed          " Use the system clipboard as default register
set colorcolumn=80             " Show a line at col 80, in case you *want* to wrap
set cursorline                 " Highlights the line the cursor is presently on
set encoding=utf-8             " No reason not to write in utf-8 as a default now
set gdefault                   " Replace all occurrences in line by default
set linebreak                  " VIM wraps at `breakat` instead of last character that fits
set numberwidth=5              " Column width for line numbers, will never exceed 5 because of relnums
set relativenumber             " 7.3 introduced this; relative line numbers
set ruler                      " Makes navigating TraceBacks just a bit easier
set scrolloff=7                " Changes when VIM starts scrolling file (i.e. cursor two lines from bottom)
set shiftround
set shiftwidth=4               " Indents use four spaces
let &showbreak = '++'
set smarttab
set tabstop=4
set textwidth=0                " Somehow getting set to 78, which is weird
set nowrap                     " Wrapping just looks odd on top of being a nuisance

set listchars=tab:\»\ ,eol:¬,trail:⋅,nbsp:⋅ " Used with `set list`

" }}}

" Status line {{{
" =============================================================================

" Powerline has taken over

" set laststatus=2
" set statusline=
" set statusline+=\ %< " Where to truncate the line
" set statusline+=%f " Path relative to cwd and file name
" set statusline+=%q " Quickfix/location list flag
" set statusline+=\ [
" set statusline+=%{strlen(&filetype)?&filetype:''} " File type in buffer
" set statusline+=%W " Preview window flag
" set statusline+=%R " Readonly flag
" set statusline+=%{','.&ff} " File format
" set statusline+=%{strlen(&fenc)?','.&fenc:',No\ Encoding'}, " File encoding
" set statusline+=%{ShowSpell()}
" set statusline+=%{ShowWrap()}
" set statusline+=%{MixedIndentWarning()}
" " set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%{TrailingWhitespaceWarning()}
" set statusline+=]
" set statusline+=%m " Modified flag
" set statusline+=\ %=
" set statusline+=%l:%c " Line Number:Column number/Virtual column number
" set statusline+=/%L " /Number of lines in buffer
" set statusline+=\ (%P)\  " Percentage through file

function! ShowSpell()
	if &spell
		return ",spell"
	else
		return ""
endfunction

function! ShowWrap()
	if &wrap
		return ",wrap"
	else
		return ""
endfunction

function! MixedIndentWarning()
	if !exists("b:mixed_indent_warning")
		let tabs = search('^\t\+', 'nw') != 0
		" ignore spaces just before JavaDoc style comments
		let spaces = search('^ \+\(\*\@!\)', 'nw') != 0
		let mixed = search('^\( \+\t\|\t\+ \+\(\*\@!\)\)', 'nw') != 0

		if mixed || (spaces && tabs)
			let b:mixed_indent_warning = ',mixed'
		elseif spaces
			let b:mixed_indent_warning = ',spaces'
		else
			let b:mixed_indent_warning = ',tabs'
		endif
		let b:mixed_indent_warning_bools = [mixed,tabs,spaces]
	endif
	return b:mixed_indent_warning
endfunction

function! TrailingWhitespaceWarning()
	if !exists("b:trailing_whitespace_warning")
		if search('\s\+$', 'nw') != 0
			let b:trailing_whitespace_warning = ',\s'
		else
			let b:trailing_whitespace_warning = ''
		endif
	endif
	return b:trailing_whitespace_warning
endfunction

autocmd CursorHold,BufWritePost * unlet! b:mixed_indent_warning
autocmd CursorHold,BufWritePost * unlet! b:trailing_whitespace_warning

" }}}

" Plugin specific settings {{{
" =============================================================================

" Solarized
let g:solarized_underline=0

" Syntastic
let g:syntastic_enable_signs=1

" Tagbar
let g:tagbar_autofocus=1
" let g:tagbar_ctags_bin="/usr/local/bin/ctags"
nmap <F8> :TagbarToggle<CR>

" delimitMate
let delimitMate_expand_cr=1
let delimitMate_expand_space=1
let delimitMate_balance_matchpairs=1

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" GoogleReader.vim
" execute 'source ~/lib/googlereader.conf.vim'

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_persistent_input = -1
let g:ctrlp_custom_ignore = {}
let g:ctrlp_custom_ignore.dir = '\.git$\|\.hg$'
let g:ctrlp_custom_ignore.file = '\.so$'
let g:ctrlp_use_caching = 0
let g:ctrlp_show_hidden = 1

" DetectIndent
let g:detectindent_preferred_expandtab = 0
let g:detectindent_preferred_indent = 4

" Powerline
" Enable fancy triangles in Powerline if the font supports it
" let g:Powerline_symbols = 'fancy'

" NERDTree
nmap <F7> :NERDTreeToggle<CR>

" Rope
let ropevim_vim_completion=1
let ropevim_extended_complete=1

" EasyMotion highlighting
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade Comment

" Vimux bindings
nnoremap <leader>rc :PromptVimTmuxCommand<CR>
nnoremap <leader>rl :RunLastVimTmuxCommand<CR>
nnoremap <leader>ri :InspectVimTmuxRunner<CR>
nnoremap <leader>rx :CloseVimTmuxPanes<CR>
nnoremap <leader>rs :InterruptVimTmuxRunner<CR>

" Zencoding

let g:user_zen_leader_key = '<c-e>'
let g:user_zen_settings = { 'indentation': '	' }

" NERDTree
let NERDTreeHijackNetrw=1

" }}}

" Functions {{{
" =============================================================================

" Does what it says
function! ToggleSpellCheck ()
	if !&spell
		setlocal spell spelllang=en_ca
	else
		setlocal nospell
	endif
endfunction

imap <silent> <F4> <Esc>:call ToggleSpellCheck()<CR>i
nmap <silent> <F4> :call ToggleSpellCheck()<CR>

function! EnsureDirExists ()
	let required_dir = expand("%:h")
	if !isdirectory(required_dir)
		call mkdir(required_dir, 'p')
	endif
endfunction

function! Scratch ()
	split +e nofile
	set buftype=nofile
	bufhidden=hide
	setlocal noswapfile
endfunction

function! ToggleReadOnlyBit ()
	let fname = fnameescape(substitute(expand("%:p"), "\\", "/", "g"))
	checktime
	execute "au FileChangedShell " . fname . " :echo"
	if &readonly
		silent !chmod u-r %
	else
		silent !chmod u+r %
	endif
	checktime
	set invreadonly
	execute "au! FileChangedShell " . fname
endfunction

command! -nargs=0 ToggleReadOnly call ToggleReadOnlyBit()

function! SynStack()
	echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunction

nnoremap <leader>ss :call SynStack()<CR>

" }}}

" Commands {{{
" =============================================================================

command! -nargs=0 StripWhitespace %s/\s\+$//|let @/=''
nmap <silent> <leader>sw :StripWhitespace<CR>

command! -nargs=0 TabIndents %s/	/<tab>/
command! -nargs=0 SpaceIndents %s/<tab>/	/

" Python makes JSON formatting easy
command! -nargs=0 FormatJSON %!python -m json.tool

command! -nargs=0 JsBeautify call g:Jsbeautify()

command! -nargs=0 Max set lines=999 | set columns=999

command! -nargs=0 Scratch call Scratch()

" Insert frogger url for a case
command! -nargs=1 CaseUrl normal ihttp://frogger.dominknow.com/default.asp?<args>

function! MarkdownCaseLink(case)
	execute 'normal o[Link to case](http://frogger.dominknow.com/default.asp?' . a:case . ' "' . a:case . '"'
endfunction

command! -nargs=1 LinkToCase call MarkdownCaseLink(<args>)

" Re-open the current file with dos line endings
command! -nargs=0 Dos e ++ff=dos

" Show the next incident of mixed indentation
command! -nargs=0 MixedLine /^\( \+\t\|\t\+ \+\(\*\@!\)\)

" Show Ri documentation using Clam
command! -nargs=1 Ri Clam ri <args>

" }}}

" Keymaps {{{
" =============================================================================

" gq formatting now a short cut
" vmap Q gq
" nmap Q gqap

map Y y$

" Fixes regex searching?
nnoremap / /\v
vnoremap / /\v

inoremap <C-space> <C-x><C-o>
nnoremap <C-space> <C-x><C-o>

" De-highlight search when you're done
nnoremap <silent> <leader><space> :noh<cr>:match none<cr>:2match none<cr>:3match none<cr>

" Create a new split and switch to it
nnoremap <leader>vsp <C-w>v<C-w>l<C-w>=
nnoremap <leader>sp <C-w>s<C-w>j<C-w>=

" Switch to previous buffer
nnoremap <leader>q :b#<CR>

" Save yourself some time
nmap ; :
vmap ; :
inoremap jk <Esc>

" Sort CSS properties
nnoremap <leader>sortcss ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:nohlsearch<CR>

" Forgot to "sudo vim" and stuck in read-only? :w!!
cmap w!! w !sudo tee % >/dev/null

" <- -> to change buffer, ^ for a list
nmap <Left> :bp<CR>
nmap <Right> :bn<CR>
nmap <Up> :BufExplorer<CR>

nnoremap <S-h> :bp<CR>
nnoremap <S-l> :bn<CR>

" Moves the cursor back to where it started after '.'
nmap . .`[

" Toggle folds with space
nnoremap <space> za
vnoremap <space> za

" Quick new line
inoremap <C-cr> <esc>A:<cr>
inoremap <S-cr> <esc>A<cr>

" Never use it anyways
nnoremap H 0
nnoremap L $

" Just put me at the end of the line
inoremap <C-e> <ESC>A

" Edit vimrc
nmap <leader><leader>rc :e ~/.vimrc<CR>

" Who hates F1?
function! HateF1()
	if has("gui_macvim")
		if &fu
			set nofu
		else
			set fu
		endif
	endif
endfunction

nnoremap <F1> call HateF1()<CR>
inoremap <F1> <ESC>call HateF1()<CR>

" Mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
	if &wrap
		return "g" . a:movement
	else
		return a:movement
	endif
endfunction

onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Toggle "keep current line centered" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>

" Fuck off, shift+k
nnoremap K <nop>

" }}}

" Autocommands {{{
" =============================================================================

" Write all files when GVIM loses focus
autocmd FocusLost * :silent! wall

" Only show cursorline in current window
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Guess the bloody indentation of the file
" autocmd BufReadPost * :DetectIndent

" Foldmethod is marker in my vimrc
autocmd BufRead .vimrc setl foldmethod=marker

" Strip whitespace on write
autocmd BufWritePre * :silent! StripWhitespace

" Make all windows equal size on Gvim window resize
autocmd VimResized * exe "normal \<c-w>="

" Create parent directories for file if they don't exist when writing
autocmd BufWritePre * :call EnsureDirExists()

" Clean up the QuickFix window
autocmd FileType qf setl nolist nocursorline nowrap

" Only show cursorline in the current window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" Filetype specific settings
autocmd FileType css              setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType cucumber         setlocal ts=2 sw=2 expandtab
autocmd FileType eruby            setlocal ts=2 sw=2 expandtab
autocmd FileType haskell          setlocal expandtab
autocmd FileType html             setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript       setlocal foldmethod=syntax omnifunc=javascriptcomplete#CompleteJS
autocmd FileType json FormatJSON
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd FileType python           setlocal expandtab omnifunc=pythoncomplete#Complete
autocmd FileType ruby             setlocal ts=2 sw=2 expandtab foldmethod=syntax
autocmd FileType scss             setlocal ts=2 sw=2 expandtab
autocmd FileType stylus           setlocal sw=2 ts=2 et

autocmd BufNewFile,BufRead *.coffee    setlocal filetype=coffee foldmethod=indent nofoldenable
autocmd BufWritePost       *.coffee    silent CoffeeMake -b | cwindow | redraw!
autocmd BufNewFile,BufRead *.jade      setlocal filetype=jade foldmethod=indent nofoldenable
autocmd BufNewFile,BufRead *.zsh-theme setlocal filetype=zsh
autocmd BufNewFile,BufRead *.pp        setlocal filetype=puppet
autocmd BufNewFile,BufRead *.md        setlocal filetype=markdown

autocmd Filetype markdown syntax region markdownFold start="^\z(#\+\) " end="\(^#\(\z1#*\)\@!#*[^#]\)\@=" transparent fold
autocmd FileType markdown syn sync fromstart
autocmd FileType markdown set foldmethod=syntax

" }}}

