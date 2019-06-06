" AdvancedMarks/Reorder.vim: Reorder marks.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	29-May-2019	file creation
let s:save_cpo = &cpo
set cpo&vim

function! s:Parse( arguments ) abort
    let [l:marks, l:expression] = matchlist(a:arguments, '^\%(\([-a-zA-Z]*\)\%(\s\+\|$\)\)\?\(.*$\)\?')[1:2]
    return [(empty(l:marks) ? 'abcdefghijklmnopqrstuvwxyz' : AdvancedMarks#ExpandMarks(l:marks)), l:expression]
endfunction
function! AdvancedMarks#Reorder#Command( startLnum, endLnum, arguments ) abort
    let [l:marks, l:expression] = s:Parse(a:arguments)
    return AdvancedMarks#Reorder#Reorder(a:startLnum, a:endLnum, l:marks, l:expression)
endfunction
function! s:SortMarks( l1, l2 ) abort
    let [l:sortee1, l:sortee2] = [a:l1[0], a:l2[0]]

    return (type(l:sortee1) == type([]) && type(l:sortee2) == type([]) ?
    \   ingo#pos#Compare(l:sortee1, l:sortee2) :
    \   (l:sortee1 ==# l:sortee2 ? 0 : l:sortee1 ># l:sortee2 ? 1 : -1)
    \)
endfunction
function! AdvancedMarks#Reorder#GetMarksInOrder( startLnum, endLnum, markList, ... ) abort
    let l:expression = (a:0 ? a:1 : '')
    let l:save_view = winsaveview()

    let l:sorted = []
    for l:mark in a:markList
	let [l:bufNr, l:lnum, l:col] = getpos("'" . l:mark)[0:2]
	if (l:bufNr == 0 || l:bufNr == bufnr('')) && l:lnum > 0 && l:lnum >= a:startLnum && l:lnum <= a:endLnum
	    if empty(l:expression)
		let l:sortee = [l:lnum, l:col]
	    else
		call cursor(l:lnum, l:col)
		let l:sortee = eval(a:1)
	    endif
	    call add(l:sorted, [l:sortee, l:mark])
	endif
    endfor

    call sort(l:sorted, 's:SortMarks')
    if ! empty(l:expression)
	call winrestview(l:save_view)   " We've moved the cursor around, restore the original view.
    endif

    return map(l:sorted, 'v:val[1]')
endfunction
function! AdvancedMarks#Reorder#Reorder( startLnum, endLnum, marks, expression ) abort
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]
    let l:markList = split(a:marks, '\zs')
    let l:orderedMarkList = AdvancedMarks#Reorder#GetMarksInOrder(l:startLnum, l:endLnum, l:markList, a:expression)
    if empty(l:orderedMarkList)
	call ingo#err#Set('No marks found')
	return 0
    endif

    let l:originalMarkPositions = ingo#dict#FromItems(map(copy(l:markList), '[v:val, getpos("''" . v:val)]'))
    let l:foundMarksInOrder = filter(copy(l:markList), 'index(l:orderedMarkList, v:val) != -1')

    if l:orderedMarkList == l:foundMarksInOrder
	call ingo#msg#StatusMsg('Marks already ordered')
	return 1
    endif

    for l:mark in l:orderedMarkList
	call setpos("'" . remove(l:foundMarksInOrder, 0), l:originalMarkPositions[l:mark])
    endfor

    call ingo#msg#StatusMsg(printf('Reordered %d mark%s', len(l:orderedMarkList), (len(l:orderedMarkList) == 1 ? '' : 's')))
    call ingo#event#TriggerCustom('MarksUpdated')
    return 1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
