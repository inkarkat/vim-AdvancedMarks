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
"	002	30-May-2019	Report no marks found as error instead of
"                               printing a stupid status message.
"                               ENH: Pass range to consider.
"                               Pass a:FilterAndOrder, and extract filtering
"                               of existing marks (within the passed range) to
"                               AdvancedMarks#Yank#FilterMarks(). This also
"                               enables the alternative ordering by lines.
"	001	31-Oct-2017	file creation from ingocommands.vim
let s:save_cpo = &cpo
set cpo&vim

function! s:ParseArguments( ... ) abort
    let l:marks = 'abcdefghijklmnopqrstuvwxyz'
    let l:register = '"'

    if a:0 > 2
	throw 'AdvancedMarks: Too many arguments'
    elseif a:0 == 2
	let l:marks = AdvancedMarks#ExpandMarks(a:1)
	let l:register = a:2
    elseif a:0 == 1
	if len(a:1) == 1
	    let l:register = a:1
	else
	    let l:marks = AdvancedMarks#ExpandMarks(a:1)
	endif
    endif

    return [l:marks, l:register]
endfunction
function! AdvancedMarks#Yank#FilterMarks( startLnum, endLnum, markList ) abort
    let l:result = []
    for l:mark in a:markList
	let [l:bufNr, l:lnum] = getpos("'" . l:mark)[0:1]
	if (l:bufNr == 0 || l:bufNr == bufnr('')) && l:lnum > 0 && l:lnum >= a:startLnum && l:lnum <= a:endLnum
	    call add(l:result, l:mark)
	endif
    endfor
    return l:result
endfunction
function! AdvancedMarks#Yank#Marks( FilterAndOrder, startLnum, endLnum, ... ) abort
    try
	let [l:marks, l:register] = call('s:ParseArguments', a:000)

	let l:lines = ''
	let l:yankedMarks = ''
	for l:mark in call(a:FilterAndOrder, [a:startLnum, a:endLnum, split(l:marks, '\zs')])
	    let l:yankedMarks .= l:mark
	    let l:lines .= getline(line("'" . l:mark)) . "\n"
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
    catch /^AdvancedMarks:/
	call ingo#err#SetCustomException('AdvancedMarks')
	return 0
    endtry
endfunction
function! AdvancedMarks#Yank#Ranges( FilterAndOrder, startLnum, endLnum, ... ) abort
    try
	let [l:marks, l:register] = call('s:ParseArguments', a:000)
	let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

	let l:lines = []
	let l:yankedMarks = ''
	for l:lowerMark in call(a:FilterAndOrder, [l:startLnum, l:endLnum, filter(split(l:marks, '\zs'), 'v:val =~# "\\l"')])
	    let l:lowerLnum = line("'" . l:lowerMark)
	    if l:lowerLnum <= 0
		continue
	    endif

	    let l:upperMark = toupper(l:lowerMark)
	    let [l:bufNr, l:upperLnum] = getpos("'" . l:upperMark)[0:1]
	    if (l:bufNr != 0 && l:bufNr != bufnr('')) ||
	    \   (l:upperLnum <= 0) ||
	    \   (l:upperLnum < l:lowerLnum) ||
	    \   (l:lowerLnum > l:endLnum) ||
	    \   (l:upperLnum < l:startLnum)
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
    catch /^AdvancedMarks:/
	call ingo#err#SetCustomException('AdvancedMarks')
	return 0
    endtry
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
