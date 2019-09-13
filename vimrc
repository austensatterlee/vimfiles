set nocompatible              " be iMproved, required
let mapleader = ","

" +----------------+
" |     Plug       |
" +----------------+

if has("win32")
    let s:myconfigdir = expand("~/vimfiles", ":p")
else
    let s:myconfigdir = expand("~/.vim", ":p")
endif

" Install vim-plug if we don't already have it
if empty(glob(s:myconfigdir . '/autoload/plug.vim'))
    exe '!curl -fLo ' . s:myconfigdir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    " silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    " \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(s:myconfigdir . '/bundle')

Plug 'mileszs/ack.vim'

Plug 'kien/ctrlp.vim'

Plug 'yegappan/mru'

Plug 'scrooloose/nerdcommenter'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'majutsushi/tagbar'

Plug 'Lokaltog/vim-easymotion'

Plug 'tpope/vim-endwise'

Plug 'xolox/vim-misc'

Plug 'tpope/vim-scriptease'

Plug 'tpope/vim-sensible'

Plug 'xolox/vim-session'

Plug 'tpope/vim-surround'

Plug 'Valloric/MatchTagAlways'

Plug 'vim-scripts/closetag.vim'

Plug 'flazz/vim-colorschemes'

Plug 'godlygeek/tabular'

Plug 'pboettch/vim-cmake-syntax'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 0 "0 if you want to enable it later via :RainbowToggle

" Enables Gblame
Plug 'tpope/vim-fugitive'

Plug 'CoatiSoftware/vim-sourcetrail'

" Enables viewing ansii color codes in vim
Plug 'powerman/vim-plugin-AnsiEsc'

" YCM
Plug 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf = 0

" Jedi (python autocomplete)
Plug 'davidhalter/jedi-vim'

Plug 'Chiel92/vim-autoformat'
let g:formatdef_autopep8 = '"autopep8 -".(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? " --range ".a:firstline." ".a:lastline : "")." ".(&textwidth ? "--max-line-length=".&textwidth : "")." --ignore=E501"'

set completeopt=menuone,noinsert

call plug#end()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"
set autochdir
set backup
let &backupdir = s:myconfigdir . '/view'
let &viewdir = s:myconfigdir . '/backup'

set exrc
set secure

set rnu
set ruler
"set list
set nolist
set showcmd
set showmode
set showmatch
set scrolloff=7
set backspace=eol,start

" Make tabs == 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab

" text formatting
set textwidth=80
set colorcolumn=80
set encoding=utf-8
highlight ColorColumn ctermbg=darkgray

" set equalprg=par\ -jw74
set listchars=tab:>-,trail:-
" Set status bar
set statusline-=[%{&fo}]
set statusline+=[%{&fo}]
set formatoptions-=t

" Fold column
set foldcolumn=2

" Don't beep
set visualbell
set noerrorbells

" Change cursor type for insert/command
set nu

if has("win32")
    " Convenient command to see the difference between the current
    " buffer and the " file it was loaded from, thus the changes you made.
    " Only define it when not defined already.
    if !exists(":DiffOrig")
        command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
                    \ | diffthis | wincmd p | diffthis
    endif
endif

if !exists("vimrc_autocommands_loaded")
    let vimrc_autocommands_loaded = 1

    " vim -b : edit binary using xxd-format!
    augroup Binary
        au!
        au BufReadPre  *.bin,*.mid let &bin=1
        au BufReadPost *.bin,*.mid if &bin | %!xxd
        au BufReadPost *.bin,*.mid set ft=xxd | endif
        au BufWritePre *.bin,*.mid if &bin | %!xxd -r
        au BufWritePre *.bin,*.mid endif
        au BufWritePost *.bin,*.mid if &bin | %!xxd
        au BufWritePost *.bin,*.mid set nomod | endif
    augroup END

    augroup SwitchLineNumbers
        autocmd InsertEnter * :set nornu
        autocmd InsertLeave * :set rnu
        autocmd WinLeave * set nocursorline
        autocmd WinLeave * set nocursorcolumn
        autocmd WinEnter * set cursorline
        autocmd WinEnter * set cursorcolumn
    augroup END

    " Open NERDTree automatically when vim starts up if no files were
    " specified
    augroup OpenNERDTree
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    augroup END

    augroup RecalcStatusWarnings
        " Recalculate the trailing whitespace warning when idle, and after saving
        autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
        " Recalculate the tab warning flag when idle and after writing
        autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
        " Recalculate the long line warning when idle and after saving
        autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning
    augroup END
endif

" NERDTree settings
let NERDTreeIgnore = ['\~$','\.pyc$','\.swp$']
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 30
let g:NERDTreeChDirMode = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowFiles = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksSort = 1
let NERDTreeHijackNetrw=1
"
" NERDCommenter settings
let g:NERDSpaceDelims = 1

" Session settings
let g:session_autosave = 'no'
let g:session_autoload = 'yes'

" Status line (from scrooloose's vimfile)
set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

"display value of the current character
set statusline+=[%b\ 0x%B%*]

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"easymotion config
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" conque config
let g:ConqueTerm_FastMode = 1

" ctrl-p options
let g:ctrlp_extensions = ['buffertag', 'line', 'tag', 'dir', 'changes', 'quickfix', 'rtscript', 'undo',
            \ 'mixed', 'bookmarkdir']
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 1

" Ignore these directories
set wildignore+=*/build/**
set wildignore+=*/out/**
set wildignore+=*/vendor/**

if !has('gui')
    " set term=xterm-256color
    " set <Up>=OA
    " set <xUp>=[A
    " set <Left>=OD
    " set <xLeft>=[D
    " set <Right>=OC
    " set <xRight>=[C
    " set <Down>=OB
    " set <xDown>=[B
endif

" Redirects output of a command into a new tab
function! TabMessage(cmd)
    redir => message
    silent execute a:cmd
    redir END
    if empty(message)
        echoerr "no output"
    else
        " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
        tabnew
        setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
        silent put=message
    endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)


" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
                \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction

set modeline

" Autoform with <leader>pp
noremap <leader>pp :Autoformat<CR>

" Use <leader>ml to add a modeline to the current file
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Use jk to enter command mode
inoremap jk <Esc>

" Remap q to Q
nnoremap Q q
nnoremap q <Nop>

" Smart home feature
" Home takes you to the first non-blank character of the line, unless you're already there.
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Map nerdtree to ctrl-n
nnoremap <leader><C-n> :NERDTreeToggle<CR>
nnoremap <leader>tb :TagbarToggle<CR>

" Session shortcuts
noremap <leader>ss :SaveSession<CR>
noremap <leader>os :OpenSession<CR>

" Make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

map <Leader>fp :CtrlPMixed<cr>
map <Leader>Fp :CtrlPBufTagAll<cr>

" Reopen closed window
nmap <c-s-t> :vs<bar>:b#<CR>
