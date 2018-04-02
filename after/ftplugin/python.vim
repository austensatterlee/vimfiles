" Make tabs == 4 spaces
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

" set foldmethod=indent
au BufWinLeave *.py mkview
au BufWinEnter *.py silent loadview
set listchars=tab:>-,trail:~
set list

setlocal foldmethod=expr
setlocal foldexpr=GetPythonFold(v:lnum)

function! GetPythonFold(lnum)
    line = getline(a:lnum)
    if line =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(GetNextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

function! GetIndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! GetNextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction
