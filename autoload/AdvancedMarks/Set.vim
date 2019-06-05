" AdvancedMarks/Set.vim: Set marks with more power.
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
"	002	01-Apr-2019	Refactoring: Use ingo#pos#Make4().
"	001	31-Oct-2017	file creation from ingocommands.vim

let s:save_cpo = &cpo
set cpo&vim

function! AdvancedMarks#Set#Marks( isGlobalMarks, arguments )
    let l:records = split(a:arguments, '[^[:digit:]:]\+')
    let l:locations =
    \   map(
    \       filter(
    \           map(
    \               l:records,
    \               'matchlist(v:val, ''^\(\d\+\)\%(:\(\d\+\)\)\?$'')'
    \           ),
    \           '! empty(v:val)'
    \       ),
    \       'v:val[1:2]'
    \   )
    if empty(l:locations)
	call ingo#err#Set('No lnum[:col] passed')
	return 0
    endif

    let l:targetMarks = a:isGlobalMarks ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : 'abcdefghijklmnopqrstuvwxyz'
    let l:invalidLocations = []
    let l:setMarks = []
    try
	while ! empty(l:locations)
	    let l:location = map(remove(l:locations, 0), 'str2nr(v:val)')

	    let l:col = (len(l:location) > 1 ?
	    \   ingo#mbyte#virtcol#GetColOfVirtCol(l:location[0], l:location[1]) :
	    \   1
	    \)
	    let l:markPos = ingo#pos#Make4(l:location[0], l:col)

	    let l:mark = ingo#plugin#marks#Reuse(l:markPos, l:targetMarks)
	    if empty(l:mark)
		let l:mark = ingo#plugin#marks#FindUnused(l:targetMarks)
	    endif

	    let l:renderedLocation = l:location[0] . (empty(l:location[1]) ? '' : ':' . l:location[1])
	    if setpos("'" . l:mark, l:markPos) == 0
		if empty(getline(l:location[0])[l:location[1] :])
		    call add(l:invalidLocations, printf('%s:%s', l:mark, l:renderedLocation))
		endif
		call add(l:setMarks, printf('%s:%s', l:mark, l:renderedLocation))
	    else
		call add(l:invalidLocations, l:renderedLocation)
	    endif
	endwhile

	call ingo#msg#StatusMsg(printf('Set %d mark%s: %s', len(l:setMarks), (len(l:setMarks) == 1 ? '' : 's'), join(l:setMarks, ' ')))
	return 1
    catch /^ReserveMarks:/
	call ingo#err#Set(printf('Ran out of marks; %d location%s not marked.', len(l:locations) + 1, (len(l:locations) == 0 ? '' : 's')))
	return 0
    finally
	if len(l:invalidLocations) > 0
	    call ingo#msg#WarningMsg(printf('Invalid location%s: %s', len(l:invalidLocations) == 1 ? '' : 's', join(l:invalidLocations, ' ')))
	endif
    endtry
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
