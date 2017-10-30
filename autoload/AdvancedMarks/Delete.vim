" AdvancedMarks/Delete.vim: Delete marks with more power.
"
" DEPENDENCIES:
"   - ingo/err.vim autoload script
"   - ingo/str/frompattern.vim autoload script
"
" Copyright: (C) 2013-2017 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	31-Oct-2017	file creation from ingocommands.vim

function! AdvancedMarks#Delete#Marks( isBang, marks )
    try
	if empty(a:marks)
	    if a:isBang
		delmarks A-Z
		execute 'Bufdo delmarks a-z'
		wviminfo!
	    else
		delmarks A-Za-z
	    endif
	else
	    if a:isBang
		let l:bufferMarks = join(ingo#str#frompattern#Get(a:marks, '\l\+-\l\+\|[[:lower:]''`"[\]<>^.(){}]\+', '', 0, 0), '')
		let l:globalMarks = join(ingo#str#frompattern#Get(a:marks, '[[:upper:][:digit:]]\+-[[:upper:][:digit:]]\+\|[[:upper:][:digit:]]\+', '', 0, 0), '')

		if ! empty(l:globalMarks)
		    execute 'delmarks' l:globalMarks
		endif

		if ! empty(l:bufferMarks)
		    execute 'Bufdo delmarks' l:bufferMarks
		endif

		wviminfo!
	    else
		execute 'delmarks' a:marks
	    endif
	endif

	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
