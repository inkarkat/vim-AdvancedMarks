" AdvancedMarks/Yank.vim: Yank marks with more power.
"
" DEPENDENCIES:
"   - ingo/msg.vim autoload script
"
" Copyright: (C) 2013-2017 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	31-Oct-2017	file creation from ingocommands.vim

function! AdvancedMarks#Yank#Arguments( ... )
    let l:marks = 'abcdefghijklmnopqrstuvwxyz'
    let l:register = '"'
    if a:0 > 2
	call ingo#msg#ErrorMsg('Too many arguments')
	return []
    elseif a:0 == 2
	let l:marks = a:1
	let l:register = a:2
    elseif a:0 == 1
	if len(a:1) == 1
	    let l:register = a:1
	else
	    let l:marks = a:1
	endif
    endif

    return [l:marks, l:register]
endfunction
function! AdvancedMarks#Yank#Marks( arguments )
    if empty(a:arguments)
	return
    endif
    let [l:marks, l:register] = a:arguments

    let l:lines = ''
    let l:yankedMarks = ''
    for l:mark in split(l:marks, '\zs')
	let [l:bufNr, l:lnum] = getpos("'" . l:mark)[0:1]
	if l:bufNr != 0 && l:bufNr != bufnr('') || l:lnum <= 0
	    continue
	endif

	let l:yankedMarks .= l:mark
	let l:lines .= getline(l:lnum) . "\n"
    endfor

    call setreg(l:register, l:lines, 'V')

    call ingo#msg#StatusMsg(printf('Yanked %d line%s from mark%s %s',
    \   len(l:yankedMarks),
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   join(split(l:yankedMarks, '\zs'), ', ')
    \) . (l:register ==# '"' ? '' : ' into register ' . l:register))
endfunction
function! AdvancedMarks#Yank#Ranges( arguments )
    if empty(a:arguments)
	return
    endif
    let [l:marks, l:register] = a:arguments

    let l:lines = []
    let l:yankedMarks = ''
    for l:startMark in filter(split(l:marks, '\zs'), 'v:val =~# "\\l"')
	let l:startLnum = line("'" . l:startMark)
	if l:startLnum <= 0
	    continue
	endif

	let l:endMark = toupper(l:startMark)
	let [l:bufNr, l:endLnum] = getpos("'" . l:endMark)[0:1]
	if l:bufNr != 0 && l:bufNr != bufnr('') || l:endLnum <= 0
	    continue
	endif

	let l:yankedMarks .= l:startMark
	let l:lines += getline(l:startLnum, l:endLnum)
    endfor

    call setreg(l:register, join(l:lines + [''], "\n"), 'V')

    call ingo#msg#StatusMsg(printf('Yanked %d line%s from mark ranges %s %s',
    \   len(l:lines),
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   join(split(l:yankedMarks, '\zs'), ', ')
    \) . (l:register ==# '"' ? '' : ' into register ' . l:register))
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
