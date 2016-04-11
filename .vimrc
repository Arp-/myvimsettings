
"" VUNDLE SETTINGS --------------------------------------------------------- {{{

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
"" My node plugins
Plugin 'Shutnik/jshint2.vim'
Plugin 'jelera/vim-javascript-syntax'
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'timcharper/textile.vim'
Plugin 'dag/vim2hs'
Plugin 'dcharbon/vim-flatbuffers'
Plugin 'elixir-lang/vim-elixir'
"Plugin 'neovimhaskell/haskell-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" }}} ---------------------------------------------------------- VUNDLE SETTINGS

"" VIM2HS SETTINGS --------------------------------------------------------- {{{

"" Dunno do something here if i want

" }}} ---------------------------------------------------------- VIM2HS SETTINGS

"" VIM GLOBAL SETTINGS ----------------------------------------------------- {{{

syntax on
set number
"set nofoldenable

"" For windows cygwin set some characters? 
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"" Display the statusline, or not to display the statusline ""
set laststatus=1 
set shiftwidth=2
set tabstop=2
set smartindent
set list listchars=tab:»·,trail:·,extends:#,nbsp:·,eol:¢
set mouse=a
set scrolloff=10
set autoread
set history=200
set textwidth=80
set hidden
set nowrap
set smartcase
set incsearch
set hlsearch
set nobackup
set noswapfile
set showcmd
set pastetoggle=<F5>

"Margin"
set colorcolumn=81,121

""Colorscheme"
set t_Co=256
colorscheme jellybeans


"" overwrite leader key"
let mapleader = '-'


"" let netrw tree style
let g:netrw_liststyle=3


"C++ completion settings"
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_LocalSearchDecl = 0


""Enable autocompletion to javascript files using <C-x><C-o>
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS


filetype plugin indent on

" }}} ------------------------------------------------------ VIM GLOBAL SETTINGS

"" VIM FUNCTIONS ----------------------------------------------------------- {{{

:function ScrollBindAll()
:	windo set scrollbind
:	echom "Scroll bind on all windows"
:endfunction


:function ScrollBindNone()
:	windo set noscrollbind
:	echom "Scroll bind off for all windows"
:endfunction


"javascript specific settings because of reasons :("
function JavascriptSyntax()
	set expandtab
	set textwidth=120
	set shiftwidth=4
	set tabstop=4
endfunction


function CppSyntax()
	set expandtab!
	set textwidth=80
	set shiftwidth=2
	set tabstop=2
endfunction


"" Helper function that creates sw sized spaces
function SWSpace()
	let myspace = ""
	let i = 0
	while i <=# &l:shiftwidth - 1
		let myspace = myspace . " "
		let i = i + 1
	endwhile
	return myspace
endfunction


"" Function that can soft or hard tab
function Tab(tabType)
	let myspace = SWSpace()
	if a:tabType ==? "soft"
		:%s/\t/\=myspace/ge
	elseif a:tabType ==? "hard"
		execute '%s/' . myspace . '/\t/g'
	endif
endfunction


"" Probably a super clever tab
function! SuperCleverTab()
	if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
		return "\<Tab>"
	else
		if &omnifunc !=# ''
			return "\<C-X>\<C-O>"
		elseif &dictionary != ''
			return "\<C-K>"
		else
			return "\<C-N>"
		endif
	endif
endfunction

function! EchoPath()
	let a:path = expand('<sfile>:p')
	echo a:path
endfunction


" }}} ------------------------------------------------------------ VIM FUNCTIONS

"" VIM COMMANDS ------------------------------------------------------------ {{{

"create Trim command:"
:command Trim :%s/\s\+$//e


"Substitutes 3 or more empty lines after each other -to-> 2 empty lines
:command RemoveBlankLines %s/\n\{3,\}/\r\r\r/ge

" }}} ------------------------------------------------------------- VIM COMMANDS

"" VIM MAPPINGS ------------------------------------------------------------ {{{

map <silent> <F9> :call ScrollBindAll()<CR>
map <silent> <F10> :call ScrollBindNone()<CR>


"jumping between different tags forward and backward"
nmap <F3> <C-]>
nmap <F2> <C-t>
imap <F3> <C-]>
imap <F2> <C-t>


"" Moving around (probably)
nmap <C-H> <C-W>h 
nmap <C-J> <C-W>j 
nmap <C-K> <C-W>k 
nmap <C-L> <C-W>l 


"" clear search highlight"
nmap <silent> ,/ :nohlsearch<CR>


"" Easy tab navigation"
imap <silent> <F6> <ESC>:tabp<CR>i
nmap <silent> <F6> <ESC>:tabp<CR>
imap <silent> <F7> <ESC>:tabn<CR>i
nmap <silent> <F7> <ESC>:tabn<CR>


"" Easy window navigation"
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
imap <silent> <A-Up> <ESC> :wincmd k<CR>i
imap <silent> <A-Down> <ESC> :wincmd j<CR>i
imap <silent> <A-Left> <ESC> :wincmd h<CR>i
imap <silent> <A-Right> <ESC> :wincmd l<CR>i


"" Moving lines up and down"
nmap <silent> <C-j> :m+<CR>==
nmap <silent> <C-k> :m-2<CR>==
imap <silent> <C-j> <Esc>:m+<CR>==gi
imap <silent> <C-k> <Esc>:m-2<CR>==gi
vmap <silent> <C-j> :m'>+<CR>gv=gv
vmap <silent> <C-k> :m-2<CR>gv=gv


"" Toggle tag list on the left side"
imap <silent> <F4> <ESC>:TlistToggle<cr>i
map <silent> <F4> :TlistToggle<cr>


"" Move by row instead of line"
nnoremap <silent> <down> gj
nnoremap <silent> <up> gk


"" Exit to normal mode on insert
imap <silent> <A-l> <ESC>l
imap <silent> <A-h> <ESC>h
imap <silent> <A-k> <ESC>k
imap <silent> <A-j> <ESC>j


"" set tab navigation to <A-q> <A-w>
nmap ÷ gT
nmap × gt


"" page-up page-down easyfier
nmap ” [5~
nmap Ł [6~


"" Make tab width to 80 character long
"nmap <silent> <A-í> 
"nmap <silent> <A-y> 


"" 80 character long comment line
nnoremap --- i//-----------------------------------------------------------------------------//<cr><bs><bs><ESC>


"" Easly search text in files
nnoremap <S-Left> <esc>:cp<cr>
nnoremap <S-Right> <esc>:cn<cr>
nnoremap <S-Up> <esc>:copen<cr>
nnoremap <S-Down> <esc>:cclose<cr>

"" Make easyer excape to normal mode
inoremap qq <c-c>

"" onoremap ius <esc>ma:.s/\\(_\\|^\\|$\\)/\\1<cr>`aNvnx


" }}} ------------------------------------------------------------- VIM MAPPINGS
"
"" VIM ABBREVIATIONS ------------------------------------------------------- {{{

" NOTE MAKE SOME USE OF THIS

" }}} -------------------------------------------------------- VIM ABBREVIATIONS
"
"" VIM AUTOCOMMANDS -------------------------------------------------------- {{{

"" automaticly 4 space expandtab

augroup plain_textfile_settings
	autocmd!
	autocmd FileType text :set wrap tw=0
augroup END

augroup textile_settings
	autocmd!
	autocmd FileType textile :set wrap tw=0 et
augroup END

augroup htmldjango_settings
	autocmd!
	autocmd FileType htmldjango :set et tw=0
augroup END

augroup haskell_settings
	autocmd!
	autocmd FileType haskell :set nofen et sw=4 ts=4
augroup END

augroup python_settings
	autocm!
	autocmd FileType python :set et tw=0 sw=4 ts=4
augroup end

"" TODO remove nowrap is filetype is not a text
""autocmd FileType text :set nowrap

augroup javascript_settings
	autocmd!
	autocmd FileType javascript :call JavascriptSyntax() 
augroup END

augroup vim_settings
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup json_settings
	autocmd!
	autocmd FileType json :set et sw=4 ts=4
augroup END

augroup cmake_settings
	autocmd!
	autocmd FileType cmake :set et sw=2 ts=2
augroup END

" }}} --------------------------------------------------------- VIM AUTOCOMMANDS
