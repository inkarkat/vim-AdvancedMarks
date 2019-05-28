" AdvancedMarks.vim: Work with marks with more power.
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

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_AdvancedMarks') || (v:version < 700)
    finish
endif
let g:loaded_AdvancedMarks = 1

command! -bar -range=% -nargs=* YankMarksByMark      if ! AdvancedMarks#Yank#Marks (<line1>, <line2>, AdvancedMarks#Yank#Arguments(<f-args>)) | echoerr ingo#err#Get() | endif
command! -bar -range=% -nargs=* YankMarkRangesByMark if ! AdvancedMarks#Yank#Ranges(<line1>, <line2>, AdvancedMarks#Yank#Arguments(<f-args>)) | echoerr ingo#err#Get() | endif
command! -bar -range=% -nargs=* ReorderMarks         if ! AdvancedMarks#Reorder#Command(<line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -nargs=1 SetMarks if ! AdvancedMarks#Set#Marks(0, <q-args>) | echoerr ingo#err#Get() | endif
command! -bang -nargs=1 SetMARKS if ! AdvancedMarks#Set#Marks(1, <q-args>) | echoerr ingo#err#Get() | endif

command! -bar -bang -nargs=? Delmarks if ! AdvancedMarks#Delete#Marks(<bang>0, <q-args>) | echoerr ingo#err#Get() | endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
