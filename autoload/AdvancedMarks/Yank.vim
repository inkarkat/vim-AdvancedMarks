" AdvancedMarks/Yank.vim: Yank marks with more power.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2013-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	31-Oct-2017	file creation from ingocommands.vim
let s:save_cpo = &cpo
set cpo&vim

function! AdvancedMarks#Yank#Arguments( ... ) abort
    let l:marks = 'abcdefghijklmnopqrstuvwxyz'
    let l:register = '"'
    if a:0 > 2
	call ingo#err#Set('Too many arguments')
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
function! AdvancedMarks#Yank#Marks( startLnum, endLnum, arguments ) abort
    if empty(a:arguments)
	return 0
    endif
    let [l:marks, l:register] = a:arguments
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

    let l:lines = ''
    let l:yankedMarks = ''
    for l:mark in split(l:marks, '\zs')
	let [l:bufNr, l:lnum] = getpos("'" . l:mark)[0:1]
	if (l:bufNr != 0 && l:bufNr != bufnr('')) || l:lnum <= 0 || l:lnum < l:startLnum || l:lnum > l:endLnum
	    continue
	endif

	let l:yankedMarks .= l:mark
	let l:lines .= getline(l:lnum) . "\n"
    endfor

    if empty(l:lines)
	call ingo#err#Set('No marks found')
	return 0
    endif

    call setreg(l:register, l:lines, 'V')

    call ingo#msg#StatusMsg(printf('Yanked %d line%s from mark%s %s',
    \   len(l:yankedMarks),
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   join(split(l:yankedMarks, '\zs'), ', ')
    \) . (l:register ==# '"' ? '' : ' into register ' . l:register))

    return 1
endfunction
function! AdvancedMarks#Yank#Ranges( startLnum, endLnum, arguments ) abort
    if empty(a:arguments)
	return 0
    endif
    let [l:marks, l:register] = a:arguments
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

    let l:lines = []
    let l:yankedMarks = ''
    for l:lowerMark in filter(split(l:marks, '\zs'), 'v:val =~# "\\l"')
	let l:lowerLnum = line("'" . l:lowerMark)
	if l:lowerLnum <= 0
	    continue
	endif

	let l:upperMark = toupper(l:lowerMark)
	let [l:bufNr, l:upperLnum] = getpos("'" . l:upperMark)[0:1]
	if (l:bufNr != 0 && l:bufNr != bufnr('')) || l:upperLnum <= 0 || l:upperLnum < l:lowerLnum || l:lowerLnum > l:endLnum || l:upperLnum < l:startLnum
	    continue
	endif

	let l:linesBetweenMarks = getline(max([l:lowerLnum, l:startLnum]), min([l:upperLnum, l:endLnum]))
	if empty(l:linesBetweenMarks)
	    continue
	endif

	let l:yankedMarks .= l:lowerMark
	let l:lines += l:linesBetweenMarks
    endfor

    if empty(l:lines)
	call ingo#err#Set('No mark ranges found')
	return 0
    endif

    call setreg(l:register, join(l:lines + [''], "\n"), 'V')

    call ingo#msg#StatusMsg(printf('Yanked %d line%s from mark ranges %s %s',
    \   len(l:lines),
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   join(split(l:yankedMarks, '\zs'), ', ')
    \) . (l:register ==# '"' ? '' : ' into register ' . l:register))

    return 1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
