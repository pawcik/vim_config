" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
  set nocompatible

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
  filetype off                    " force reloading *after* pathogen loaded
  call pathogen#helptags()
  call pathogen#runtime_append_all_bundles()
  filetype plugin indent on       " enable detection, plugins and indenting in one step

  let mapleader=","

" Editing Behaviour {{{
  syntax on
  set number
  set showmatch "highlight matching braces
  set autoindent
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set encoding=utf-8

  set smartcase "Use case insensitive search, except when using capital letters
  set incsearch "Find when typing
  set hlsearch
  set noswapfile

  color xoria256 
"}}}

" Editor Layout {{{
  set wildmenu                    " make tab completion for files/buffers act like bash
  set wildignore=*.swp,*.bak,*.pyc,*.class
" }}}

" Vim behaviour {{{ 
  set completeopt=menu,longest,preview  

" }}}

" Shortcut mappings {{{
  nnoremap ; :

  " Avoid accidental hits of <F1> while aiming for <Esc>
  map! <F1> <Esc>

  " Quickly close the current window
  nnoremap <leader>q :q<CR>
  map <silent> <t_133>9 :Commant<CR> 

  " Remap j and k to act as expected when used on long, wrapped, lines
  nnoremap j gj
  nnoremap k gk

  " to set lines 47 to remove bottom border for my dell
  map sl :set lines=47 
  nmap <leader>rr :call ReloadSnippets( snippest_dir, &filetype)<CR>

  " Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
  " yanked stack (also, in visual mode)
  nmap <silent> <leader>d "_d
  vmap <silent> <leader>d "_d

  " Yank/paste to the OS clipboard with ,y and ,p
  nmap <leader>y "+y
  nmap <leader>Y "+yy
  nmap <leader>p "+p
  nmap <leader>P "+P

  " Plugin: unimpaired
  if exists("g:loaded_unimpaired") || &cp || v:version < 700
  " Bubble single lines
    nmap <C-Up> [e
    nmap <C-Down> ]e
    " Bubble multiple lines
    vmap <C-Up> [egv
    vmap <C-Down> ]egv
  else
    " Bubble single lines
    nmap <C-Up> ddkP
    nmap <C-Down> ddp
    " " Bubble multiple lines
    vmap <C-Up> xkP`[V`]
    vmap <C-Down> xp`[V`]
  endif

  " Edit the vimrc file
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  nmap <silent> <leader>sv :so $MYVIMRC<CR>


  " ---------    SPELL     -------------
  map zp :setlocal spell spelllang=pl<CR>
  map zP :setlocal nospell<CR>
  map ze :setlocal spell spelllang=en_us<CR>
  map zE :setlocal nospell<CR>

  " Plugin: supertab
  if exists("g:SuperTabLongestEnhanced")
    let g:SuperTabLongestEnhanced = 1
  endif

"}}}

"AutoCommand  {
if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    "au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    "au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back
    
    " When using mutt, text width=72
    au FileType tex :map <F2> <Esc>:w<CR>:!pdflatex -output-directory output %<CR>
    au FileType tex :map <F3> <Esc>:w<CR>:!pdflatex -output-directory output praca.tex<CR>
    "au FileType cpp,c,java,sh,pl,php,asp  set autoindent
    "au FileType cpp,c,java,sh,pl,php,asp  set smartindent
    "au FileType cpp,c,java,sh,pl,php,asp  set cindent
    "au BufRead mutt*[0-9] set tw=72
    
    " Automatically chmod +x Shell and Perl scripts
    "au BufWritePost   *.sh             !chmod +x %
    "au BufWritePost   *.pl             !chmod +x %

    " File formats
    "au BufNewFile,BufRead  *.pls    set syntax=dosini
    "au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
endif
"}
" StatusLine {
  set laststatus=2                          "to be sure status linse is visible
  set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ENC=%{&fileencoding}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\%=[POS=%04l,%04v][%p%%]\ [LEN=%L] 
"  set statusline=
"  set statusline+=%<\                       " cut at start
"  set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
"  set statusline+=%-40f\                    " relative path
"  set statusline+=%=                        " seperate between right- and left-aligned
"  set statusline+=%1*%y%*%*\                " file type
"  set statusline+=%10((%l/%L)%)\            " line and column
"  set statusline+=%P                        " percentage of file
" }

" Folding {
  set foldenable " Turn on folding
  set foldmarker=(fold),(end) 
  set foldmethod=marker " Fold on the marker
  set foldlevel=100 " Don't autofold anything (but I can still 
                      " fold manually)
" }
"
" GUI { default agimrLtT
  set guioptions-=m " turn off menu bar
  set guioptions-=T " turn off toolbar
  set guioptions-=e " remove gui tab page
  set guioptions+=c " use console dialogs for simple choices
  set guioptions-=b " remove bottom scrollbar
  set guioptions-=r 
  set guioptions-=t 
  set guioptions-=L 
" } 

  let snippest_dir="~/.vim/snippets"
" KEYS {
" }
"
"
" FUNCTIONS () {{{
function! ReloadSnippets( snippets_dir, ft )
    if strlen( a:ft ) == 0
        let filetype = "_"
    else
        let filetype = a:ft
    endif

    call ResetSnippets()
    call GetSnippets( a:snippets_dir, filetype )
endfunction


" }}}
