" AdvancedMarks/Reorder.vim: Reorder marks.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	29-May-2019	file creation

function! s:Parse( arguments ) abort
    let [l:marks, l:expression] = matchlist(a:arguments, '^\%(\([a-zA-Z]*\)\%(\s\+\|$\)\)\?\(.*$\)\?')[1:2]
    return [(empty(l:marks) ? 'abcdefghijklmnopqrstuvwxyz' : l:marks), l:expression]
endfunction
function! AdvancedMarks#Reorder#Command( startLnum, endLnum, arguments ) abort
    let [l:marks, l:expression] = s:Parse(a:arguments)
    return AdvancedMarks#Reorder#Reorder(a:startLnum, a:endLnum, l:marks, l:expression)
endfunction
function! AdvancedMarks#Reorder#GetMarksInOrder( startLnum, endLnum, markList, ... ) abort
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

    " TODO
    return ['a', 'b', 'c']
endfunction
function! AdvancedMarks#Reorder#Reorder( startLnum, endLnum, marks, expression ) abort
    let l:markList = split(a:marks, '\zs')
    let l:orderedMarkList = AdvancedMarks#Reorder#GetMarksInOrder(a:startLnum, a:endLnum, l:markList, a:expression)
    if empty(l:orderedMarkList)
	call ingo#err#Set('No marks found')
	return 0
    elseif l:orderedMarkList == l:markList
	call ingo#msg#StatusMsg('Marks already ordered')
	return 1
    endif

    let l:originalMarkPositions = ingo#dict#FromItems(map(l:markList, '[v:val, getpos("''" . v:val)]'))
    let l:foundMarksInOrder = sort(copy(l:orderedMarkList))

    for l:mark in l:orderedMarkList
	call setpos("'" . remove(l:foundMarksInOrder, 0), l:originalMarkPositions[l:mark])
    endfor

    call ingo#msg#StatusMsg(printf('Reordered %d mark%s', len(l:orderedMarkList), (len(l:orderedMarkList) == 1 ? '' : 's')))
    return 1
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
