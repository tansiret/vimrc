""" Yutyo's vimrc - Unapologetically KISS - Just a .vimrc config


"" General
set number      " Show line numbers
syntax on       " Enable syntax highlighting
set linebreak   " Break lines at word (requires Wrap lines)
set showbreak=+++       " Wrap-broken line prefix
set textwidth=100       " Line wrap (number of cols)
set showmatch   " Highlight matching brace
set visualbell  " Use visual bell (no beeping)
set mouse=a     " Enable use of the mouse for all modes
set nowrap      " Display 

set laststatus=2        " Show the current file at the bottom

set title       " Title of the current file displayed at the tab
set showtabline=2       " Show vim tab pages all time

set hlsearch    " Highlight all search results
set smartcase   " Enable smart-case search
set ignorecase  " Always case-insensitive
set incsearch   " Searches for strings incrementally

set autoindent  " Auto-indent new lines
set expandtab   " Use spaces instead of tabs
set shiftwidth=4        " Number of auto-indent spaces
set smartindent " Enable smart-indent
set smarttab    " Enable smart-tabs
set softtabstop=4       " Number of spaces per Tab

set cursorline  " Autohighlight the line you are currently on
set showcmd     " Show command in bottom bar
set cmdheight=2 " More space to display commands
filetype indent on      " Load filetype-specific indent files
set wildmenu    " Visual autocomplete for command menu
set wildmode=list:full    "Expands wildmenu
set showmatch   " highlight matching [{()}]

set incsearch   " search as characters are entered
set hlsearch    " highlight matches


"" Advanced
set ruler       " Show row and column ruler information
set undolevels=1000     " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

set nobackup   " No backup
set nowritebackup       " No backup

set clipboard=unnamed   " Saves copied text from vim to general clipboard
set clipboard=unnamedplus       " Saves copied text from vim ro general clipboard

" Shortcuts for generic commands as alias to vim commands
:map <C-a> GVgg         " Select all 
:map <C-n> :enew        " Open new file 
:map <C-o> :e . <Enter> " Open file
:map <C-s> :w <Enter>   " Save file (use ctrl q afterwards)
:map <C-c> "y           " Copy
:map <C-v> "p           " Paste
:map <C-x> d            " Cut
:map <C-z> u            " Undo
:map <C-t> :tabnew <Enter>      " Open new tab within vim
:map <C-i> >>           " Move line
:map <C-w> :close <Enter>       " Close the tab
:map <C-W> :q! <Enter>  " Quit vim and close the window
:map <C-f> /            " Search
:map <F3> n             " Search the latest action 
:map <C-h> :%s/         " Search and replace syntax
:map <S-t> vat          " Enter visual mode 
:map <S-T> vit          " Enter visual mode 
:map <S-{> vi{          " Vi command {
:map <S-(> vi(          " Vi command ( 
:map <S-[> vi[          " Vi command [
:map <S-Right> gt       " Switch to the nex tab page
:map <S-Left> gT        " Switch to the prior tab page

cnoremap kj <C-C> " Easy navigation within the file
cnoremap jk <C-C> " Easy navigation within the file


"" Theme
colorscheme industry    " Default theme (change here for your preference)


"" Statusline
let fgcolor=synIDattr(synIDtrans(hlID("Normal")), "fg", "gui")
let bgcolor=synIDattr(synIDtrans(hlID("Normal")), "bg", "gui")

" Tabline/Buffer line
set showtabline=2
set tabline="%1T"

let g:currentmode={
      \ 'n'  : 'N ',
      \ 'no' : 'N·Operator Pending ',
      \ 'v'  : 'V ',
      \ 'V'  : 'V·Line ',
      \ 'x22' : 'V·Block ',
      \ 's'  : 'Select ',
      \ 'S'  : 'S·Line ',
      \ 'x19' : 'S·Block ',
      \ 'i'  : 'I ',
      \ 'R'  : 'R ',
      \ 'Rv' : 'V·Replace ',
      \ 'c'  : 'Command ',
      \ 'cv' : 'Vim Ex ',
      \ 'ce' : 'Ex ',
      \ 'r'  : 'Prompt ',
      \ 'rm' : 'More ',
      \ 'r?' : 'Confirm ',
      \ '!'  : 'Shell ',
      \ 't'  : 'Terminal '
      \}


highlight User1 cterm=None gui=None ctermfg=007 guifg=fgcolor
highlight User2 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User3 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User4 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User5 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User7 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User8 cterm=None gui=None ctermfg=008 guifg=bgcolor
highlight User9 cterm=None gui=None ctermfg=007 guifg=fgcolor

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=008 guifg=fgcolor gui=None cterm=None'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=005 guifg=#00ff00 gui=None cterm=None'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=004 guifg=#6CBCE8 gui=None cterm=None'
  else
    exe 'hi! StatusLine ctermfg=006 guifg=orange gui=None cterm=None'
  endif

  return ''
endfunction

" Find out current buffer's size and output it.
function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif
  if (exists('kbytes') && kbytes >= 1000)
    let mbytes = kbytes / 1000
  endif

  if bytes <= 0
    return '0'
  endif

  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B '
  endif
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
endfunction

" http://stackoverflow.com/a/10416234/213124
set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ %{GitInfo()}                        " Git Branch name
set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%#warningmsg#
set statusline+=%{neomake#statusline#LoclistStatus()}    " Neomake errors
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %{gutentags#statusline('[Generating\ tags...]')} " Tags generation
set statusline+=%8*\ %{ObsessionStatus()}                " Obsession indicator
set statusline+=%8*\ %y\                                 " FileType
set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%8*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%0*\ %3p%%\ \ %l:\ %3c\                 " Rownumber/total (%)
