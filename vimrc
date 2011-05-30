" 
" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
  set nocompatible

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
  filetype off                    " force reloading *after* pathogen loaded
  call pathogen#runtime_append_all_bundles()
  call pathogen#helptags()
  filetype plugin indent on       " enable detection, plugins and indenting in one step

  let mapleader=","
  "VIM home to 
  if has('win32') || has ('win64')
      let $VIMHOME = $HOME."\\vimfiles"
  else
      let $VIMHOME = $HOME."/.vim"
  endif
  "let $VIMHOME=expand('<sfile>:p:h')

" Editing Behaviour {{{
  syntax on
  set number
  set autoindent

  set expandtab               "insert space instead <Tab>
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2

  set smartcase "Use case insensitive search, except when using capital letters
  set ignorecase
  set showmatch "highlight matching braces
  set incsearch "Find when typing
  set hlsearch
  set noswapfile

  "to open files only in unix format, for windows display ^M for endlines
  set fileformats=unix,dos

  set encoding=utf-8

  color xoria256
  "set background=dark
  "color solarized
  "highlight current line
  set cursorline

  "tab: u25b8 ▸, eol: u00ac ¬, nbsp: u00B7 ·
  set listchars=tab:▸\ ,eol:¬,nbsp:·,trail:·
"}}}
" Editor Layout {{{
  set wildmenu                    " make tab completion for files/buffers act like bash
  set wildignore=*.swp,*.bak,*.pyc,*.class
" }}}

" Vim behaviour {{{
  set hidden
  set completeopt=menu,longest,preview

" }}}
" Shortcut mappings {{{
  nnoremap ; :

  " Avoid accidental hits of <F1> while aiming for <Esc>
  map! <F1> <Esc>

  " To return to normal mode by pressing twice j
  imap jj <Esc>

  " Quickly close the current window
  nnoremap <leader>q :q<CR>
  map <silent> <t_133>9 :Commant<CR>

  " Remap j and k to act as expected when used on long, wrapped, lines
  nnoremap j gj
  nnoremap k gk
  nnoremap R "_d

  " to set lines 47 to remove bottom border for my dell
  map sl :set lines=47
  nmap <leader>rr :call MyReloadSnippets(snippets_dir, &filetype)<CR>

  " Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
  " yanked stack (also, in visual mode)
  nmap <silent> <leader>d "_d
  vmap <silent> <leader>d "_d

  " Yank/paste to the OS clipboard with ,y and ,p
  nmap <leader>y "+y
  nmap <leader>Y "+yy
  nmap <leader>p "+p
  nmap <leader>P "+P

  nmap <leader>l :set list!<CR>

  "Indent block 
  nmap <A-h> <<
  nmap <A-l> >>
  vmap <A-h> <gv
  vmap <A-l> >gv

  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l


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

  " Plugin: CTags
  nnoremap <silent> <F8> :TlistToggle<CR>
  " Plugin: NERDTree
  nnoremap <silent> <F9> :NERDTreeToggle<CR>
  " Edit the vimrc file
  nmap <silent> <leader>ev :tabnew $MYVIMRC<CR>
  nmap <silent> <leader>sv :so $MYVIMRC<CR>


  " Enter to edited file's directory
  nmap <leader>cd :let $CURRENT_PATH=expand("%:p:h")<CR>:cd $CURRENT_PATH<CR>

  "open a file under cursor (split window) event if not exist
  map <leader>gf :sp <cfile><cr>

  " ---------    SPELL     -------------
  map zp :setlocal spell spelllang=pl<CR>
  map zP :setlocal nospell<CR>
  map ze :setlocal spell spelllang=en_us<CR>
  map zE :setlocal nospell<CR>


  " using to insert cs from cr
  nmap <leader>c :r !powertool -g <C-R><C-W><CR>
  nmap <leader>cx :r !powertool -x -g x<CR>

  " toggleRainbow
  nmap <leader>R :RainbowParenthsisToggle<CR>
"}}}
"
"------------------------------------------
" Omnicompletion
"------------------------------------------
"JAVA
  if has("autocmd")
	  autocmd Filetype java setlocal omnifunc=javacomplete#Complete
	endif



" Plugins settings {{{
  " Plugin: supertab
  "if exists("g:SuperTabLongestEnhanced")
    let g:SuperTabLongestEnhanced = 1
    let g:SuperTabLeadingSpaceCompletion = 0
    let g:SuperTabRetainCompletionDuration='session'
  "endif
  
  " Plugin: gtranslate {{{
  let g:langpair="en|pl"
  let g:vtranslate="T"
  " }}}
  

  " Plugin: taglist
  let Tlist_Use_Right_Window = 1
  let tlist_tex_settings='tex;c:chapters;s:sections;u:subsections;b:subsubsections;p:parts;P:paragraphs;G:subparagraphs'
  set title titlestring= "GVIM" . %<%f\%([%{Tlist_Get_Tagname_By_Line()}]%)


  " Plugin: snipmate
  " bundle/snipmate/after/plugin/snipmate
  ino <silent> <leader>s <c-r>=TriggerSnippet()<cr>
  ino <silent> <leader>, <c-r>=TriggerSnippet()<cr>
  snor <silent> <leader>, <esc>i<right><c-r>=TriggerSnippet()<cr>
  ino <silent> <leader>\< <c-r>=BackwardsSnippet()<cr>
  snor <silent> <leader>\< <esc>i<right><c-r>=BackwardsSnippet()<cr>
  ino <silent> <leader>n <c-r>=ShowAvailableSnips()<cr>

  if has('win32') || has ('win64')
      let snippets_dir=$VIMHOME . "\\snippets"
  else
      let snippets_dir=$VIMHOME . "/snippets"
  endif

  " FUNCTIONS () {{{
  function! MyReloadSnippets( snippets_dir, ft )
    if strlen( a:ft ) == 0
      let filetype = "_"
    else
      let filetype = a:ft
    endif

    call ResetSnippets(filetype)
    call GetSnippets( g:snippets_dir, filetype )
  endfunction
  
" }}}

"AutoCommand  {
if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    "au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    "au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=2 sts=2 sw=2 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " Customisations based on house-style (arbitrary)
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType md setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType snippet setlocal ts=2 sts=2 sw=2 noexpandtab

    autocmd FileType cccs setlocal cms=#%s 
    autocmd FileType cccs set foldmethod=marker

    "python
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType python set foldmethod=indent

    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml

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
    
    " Save/restore buffer state
    au BufWinLeave * silent! mkview
    au BufWinEnter * silent! loadview

    " File formats
    "au BufNewFile,BufRead  *.pls    set syntax=dosini
    "au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
    

endif
"}
" StatusLine {
  set laststatus=2                          "to be sure status linse is visible
  set statusline=%f\ %m\ %r\ %=\ [%{&fileencoding}]\ [%{&ff}]\ [ft=%{&ft}]\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][1x%B]
  " set statusline=%-9F%m%r%h%w\ [F=%{&ff}]\ [TYPE=%Y]\ [ENC=%{&fileencoding}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\%=[POS=%04l,%04v][%p%%]\ [LEN=%L]
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
  " In GVIM
  if has("gui_running")
    set guioptions-=m " turn off menu bar
    set guioptions-=T " turn off toolbar
    set guioptions-=e " remove gui tab page
    set guioptions+=c " use console dialogs for simple choices
    set guioptions-=b " remove bottom scrollbar
    set guioptions-=r
    set guioptions-=t
    set guioptions-=L

    if has("gui_gtk2")
      set guifont=Monospace\ 13
    elseif has("x11")
      " Also for GTK 1
      "set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("gui_win32")
      set guifont=DejaVu_LGC_Sans_Mono:h10:cANSI

    endif

  endif
  " }

  " }}}

  " TIPS {{{
  "Invisible character colors
  "highlight NonText guifg=#4a4a59
  "highlight SpecialKey guifg=#4a4a59

  "}}}
