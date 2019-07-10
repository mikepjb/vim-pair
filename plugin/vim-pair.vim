function! OpenPair(left, right)
  return a:left . a:right . "\<Left>"
endfunction

function! ClosePair(left, right)
    let current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if current_char == a:right
        return "\<Right>"
    else
        return a:right
    endif
endfunction

function! DeletePair()
    let previous_char = matchstr(getline('.'), '\%' . (col('.')-1) . 'c.')
    let current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if (current_char == ")" && previous_char == "(") ||
                \ (current_char == "]" && previous_char == "[") ||
                \ (current_char == "}" && previous_char == "{") ||
                \ (current_char == "\"" && previous_char == "\"")
        return "\<Left>\<C-o>2s"
    elseif previous_char == ")"
        return "\<Left>"
    else
        return "\<BS>"
    endif
endfunction

inoremap <expr> ( OpenPair("(",")")
inoremap <expr> [ OpenPair("[","]")
inoremap <expr> { OpenPair("{","}")
inoremap <expr> ) ClosePair("(",")")
inoremap <expr> ] ClosePair("[","]")
inoremap <expr> } ClosePair("{","}")

if has('nvim')
  inoremap <expr> <BS> DeletePair()
else
  inoremap <expr>  DeletePair()
endif
