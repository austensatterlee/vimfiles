" Highlight nonascii characters
syntax match nonascii /[^\x00-\x7F]/ containedin=ALL
highlight nonascii term=bold,underline guibg=Red ctermbg=2 
