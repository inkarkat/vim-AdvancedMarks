" AdvancedMarks/Delete.vim: Delete marks with more power.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"   - ArgsAndMore.vim plugin
"
" Copyright: (C) 2013-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	31-Oct-2017	file creation from ingocommands.vim

function! AdvancedMarks#Delete#Marks( isBang, marks )
    try
	if a:isBang
	    if empty(a:marks)
		let l:bufferMarks = 'a-z'
		let l:globalMarks = 'A-Z'
	    else
		let l:bufferMarks = join(ingo#str#frompattern#Get(a:marks, '\l\+-\l\+\|[[:lower:]''`"[\]<>^.(){}]\+', '', 0, 0), '')
		let l:globalMarks = join(ingo#str#frompattern#Get(a:marks, '[[:upper:][:digit:]]\+-[[:upper:][:digit:]]\+\|[[:upper:][:digit:]]\+', '', 0, 0), '')
	    endif

	    if ! empty(l:globalMarks)
		execute 'delmarks' l:globalMarks
	    endif

	    if ! empty(l:bufferMarks)
		execute 'Bufdo! delmarks' l:bufferMarks
	    endif

	    wviminfo!
	else
	    let l:marks = (empty(a:marks) ? 'A-Za-z' : a:marks)
	    execute 'delmarks' l:marks
	endif

	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
