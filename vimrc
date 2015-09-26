" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"
set nocompatible
" pathogen
silent execute pathogen#infect()
syntax on
filetype plugin indent on
set runtimepath^=~/vimfiles/bundle/ctrlp.vim

" Use jk to enter command mode
inoremap jk <Esc>
" Leader
let mapleader = ","
if has("win32")
        set backup
        set backupdir=~/vimfiles/backup
endif
set autochdir
set t_Co=256

set rnu
set ruler
"set list
set nolist
set showcmd
set showmode
set showmatch
set scrolloff=7
set backspace=eol,start

" Make tabs == 2 spaces
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent

" text formatting
set textwidth=74
" set equalprg=par\ -jw74
set listchars=tab:>-,trail:-
" Set status bar
set statusline-=[%{&fo}]
set statusline+=[%{&fo}]
set formatoptions-=t
" Highlight lines longer than 74
" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
"   autocmd BufEnter * match OverLength /\%74v.*/
" augroup END
" Use ,wr to wrap lines
noremap <leader>wr :g/^/norm gqq<CR>

" Fold column
set foldcolumn=2

" Don't beep
set visualbell
set noerrorbells

" Change cursor type for insert/command
autocmd InsertEnter * :set nu
autocmd InsertLeave * :set rnu
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" Shoddy comment macros
" @c to comment (identical to ,cc)
" let @c = join(["^i","#"," j"],"")
" @u to uncomment (deletes the first two characters of the line
" let @u = '^xxj'
" Comment/uncomment lines with ,cc or ,uu
" noremap <silent> <leader>cc :<C-B>silent <C-E>s/\([ ]*\)\([^ ]*\)/\1<C-R>=substitute(&commentstring,'\( \?%s \?\)','','')<CR> \2/<CR>:nohlsearch<CR>
" noremap <silent> <leader>uu :<C-B>silent <C-E>s/^\( *\)<C-R>=substitute(&commentstring,'\(%s\)','','')<CR> \?/\1/<CR>:nohlsearch<CR>


if has("win32")
        " Convenient command to see the difference between the current
        " buffer and the
        " file it was loaded from, thus the changes you made.
        " Only define it when not defined already.
        if !exists(":DiffOrig")
          command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ |
          diffthis
                          \ | wincmd p | diffthis
        endif
endif
" Override the color of the current line
hi CursorLine ctermbg=17 ctermfg=254

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

" Map nerdtree to ctrl-n
map <C-n> :NERDTreeToggle<CR>
nmap <leader>tb :TagbarToggle<CR>

" Open NERDTree automatically when vim starts up if no files were
" specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTree settings
let NERDTreeIgnore = ['\~$','\.pyc$','\.swp$']
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 30
let g:NERDTreeChDirMode = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowFiles = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksSort = 1
"
" NERDCommenter settings
let g:NERDSpaceDelims = 1

" Session settings
noremap <leader>ss :SaveSession<CR>
noremap <leader>os :OpenSession<CR>
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

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

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

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

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

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

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

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"easymotion config
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" conque config
let g:ConqueTerm_FastMode = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ctrl-p options
"let g:ctrlp_extensions = ['buffertag', 'line', 'tag', 'dir', 'changes', 'quickfix', 'rtscript',
                        "\ 'undo',  'mixed', 'bookmarkdir']
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0

" Ignore these directories
set wildignore+=*/build/**
set wildignore+=*/out/**
set wildignore+=*/vendor/**
map <Leader>fp :CtrlPBufTag<cr>
map <Leader>Fp :CtrlPBufTagAll<cr>
"" Search in certain directories a large project (hardcoded for now)
"cnoremap %proj <c-r>=expand('~/Projects/some-project')<cr>
"" ga = go api
"map <Leader>ga :CtrlP %proj/api/<cr>
"" gf = go frontend
"map <Leader>gf :CtrlP %proj/some/long/path/to/frontend/code/<cr>
set term=xterm-256
