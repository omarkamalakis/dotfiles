let mapleader = " "
source $HOME/.config/nvim/cocrc.vim
source $HOME/.config/nvim/startifyrc.vim

"=====================
"VIM PLUG
"=====================
call plug#begin('~/.config/nvim/plugged')
"File Navigation
Plug 'scrooloose/nerdtree'

"Task/Project Management + Knowledge Base
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'michal-h21/vim-zettel'
Plug 'tbabej/taskwiki'

"Movement Tools
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'

"Git tools
Plug 'tpope/vim-fugitive'

"IDE-like tools
Plug 'airblade/vim-rooter'
Plug 'LukeSmithxyz/vimling'
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'sirver/ultisnips'
Plug 'wellle/context.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'cespare/vim-toml'

"Productivity
Plug 'tpope/vim-obsession'

"Visual Tools
Plug 'junegunn/goyo.vim'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-which-key'

"A E S T H E T I C S
Plug 'vim-airline/vim-airline'
Plug 'ayu-theme/ayu-vim'
Plug 'mkitt/tabline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'machakann/vim-highlightedyank'
Plug 'joeytwiddle/sexy_scroller.vim'
Plug 'mhinz/vim-startify'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'miyakogi/seiya.vim'

call plug#end()

"=====================
"THEMING
"=====================

" set bg=dark
set termguicolors
let ayucolor="dark"
colorscheme ayu

" transparency
let g:seiya_auto_enable=1
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

"Airline
let g:airline_powerline_fonts=1
let g:airline_extensions = ['coc', 'vista']

"=====================
"GENERAL SETTINGS
"=====================

set mouse=a
set nohlsearch
set clipboard=unnamedplus
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set ttyfast
"Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
" Enable autocompletion:
set wildmode=longest,list,full
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"=====================
"Quality of Life Keybinds:
"=====================
" Easymotion
nmap <leader>d <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" Search
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Center Search Results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" FZF Preview Navigation
noremap <leader>sd :CocCommand fzf-preview.DirectoryFiles<CR>
noremap <leader>ss :CocCommand fzf-preview.ProjectFiles<CR>
noremap <leader>sg :CocCommand fzf-preview.GitFiles<CR>
noremap <leader>sb :CocCommand fzf-preview.Buffers<CR>
noremap <leader>sB :CocCommand fzf-preview.Bookmarks<CR>
noremap <leader>sl :CocCommand fzf-preview.Lines<CR>
noremap <leader>sj :CocCommand fzf-preview.Jumps<CR>

"=====================
"Prose/Documents
"=====================
" Prose Mode
nm <leader>q :call ToggleProse()<CR>

" Open bibliography file in split
map <leader>b :vsp<space>$BIB<CR>
map <leader>r :vsp<space>$REFER<CR>

" Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set linebreak<CR>

" Enable Goyo by default for mutt writting
" Goyo's width will be the line limit in mutt.
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Clear tex files on exit
autocmd VimLeave *.tex !texclear %

" FileTypes for opening
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Skeleton files (for MOM)
	if has("autocmd")
		augroup templates
			autocmd BufNewFile *.mom 0r ~/.skeleton/skeleton.mom
		augroup END
	endif

"MARKDOWN
autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

" Vimwiki Settings
let g:vimwiki_ext2syntax = {'.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/zettel'},{'path': '~/vimwiki', 'auto_tags':1, 'auto_toc':1}, ]
let g:vimwiki_use_mouse = 1
let g:vimwiki_folding = 'expr'
let g:vimwiki_auto_chdir = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_use_calendar = 1

let g:calendar_options = 'nornu'


"=====================
" Development
"=====================
" Disable Emmet except on HTML/CSS files
	let g:user_emmet_install_global = 0
	autocmd FileType html,css EmmetInstall

" Context.Vim
	let g:context_enabled = 0
	nnoremap <leader>x :ContextToggle<cr>

" TMUX Navigation
	nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
	nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
	nnoremap <silent> <C-Up>   :TmuxNavigateUp<cr>
	nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
	nnoremap <silent> <C-BS> :TmuxNavigatePrevious<cr>

" Ulti Snips
	let g:UltiSnipsExpandTrigger="<c-space>"

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

"For Bash and System Configs

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost ~/.bmdirs,~/.bmfiles !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Nerd tree
	map <C-n> :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Vista
nnoremap <leader>v :Vista!!<CR>
let g:vista_executive_for = {
	\ 'go': 'ctags',
	\ 'rust': 'ctags',
	\ 'python': 'coc',
	\ 'markdown': 'toc',
	\ 'bash': 'coc',
	\ 'javascript': 'coc',
	\ }
let g:vista_enable_markdown_extension=1
let g:vista_stay_on_open=0
let g:vista_echo_cursor_strategy=3
