function! s:open_pair(left, right)
  return a:left . a:right . "\<Left>"
endfunction

function! s:close_pair(left, right)
    let current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if current_char == a:right
        return "\<Right>"
    else
        return a:right
    endif
endfunction

function! s:delete_pair()
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

inoremap <expr> ( :call <sid>open_pair("(",")")
inoremap <expr> [ :call <sid>open_pair("[","]")
inoremap <expr> { :call <sid>open_pair("{","}")
inoremap <expr> ) :call <sid>close_pair("(",")")
inoremap <expr> ] :call <sid>close_pair("[","]")
inoremap <expr> } :call <sid>close_pair("{","}")
inoremap <expr>  :call <sid>delete_pair()
