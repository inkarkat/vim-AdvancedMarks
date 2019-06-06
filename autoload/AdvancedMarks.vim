" AdvancedMarks.vim: Common function for mark works.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! s:ExpandRange( startMark, endMark ) abort
    if a:startMark . a:endMark !~# '^\%(\l\l\|[[:upper:][:digit:]]\{2}\)$'
	throw printf('AdvancedMarks: Invalid mark range: %s-%s', a:startMark, a:endMark)
    endif
    let [l:start, l:end] = [char2nr(a:startMark), char2nr(a:endMark)]
    if l:start > l:end
	throw printf('AdvancedMarks: Invalid mark range: %s-%s', a:startMark, a:endMark)
    endif
    return join(map(range(l:start, l:end), 'nr2char(v:val)'), '')
endfunction
function! AdvancedMarks#ExpandMarks( marks ) abort
    return substitute(a:marks, '\(.\?\)-\(.\?\)', '\=s:ExpandRange(submatch(1), submatch(2))', 'g')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
