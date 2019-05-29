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
"	002	30-May-2019	Split :YankMark{s,Ranges} into ...ByMark and
"                               ...ByLines variants.
"                               ENH: Pass range to consider for :YankMark*
"                               commands.
"                               Add :ReorderMarks.
"	001	31-Oct-2017	file creation from ingocommands.vim

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_AdvancedMarks') || (v:version < 700)
    finish
endif
let g:loaded_AdvancedMarks = 1
let s:save_cpo = &cpo
set cpo&vim

command! -bar -range=% -nargs=* YankMarksByMark
\ if ! AdvancedMarks#Yank#Marks(function('AdvancedMarks#Yank#FilterMarks'), <line1>, <line2>, AdvancedMarks#Yank#Arguments(<f-args>)) | echoerr ingo#err#Get() | endif
command! -bar -range=% -nargs=* YankMarksByLines
\ if ! AdvancedMarks#Yank#Marks(function('AdvancedMarks#Reorder#GetMarksInOrder'), <line1>, <line2>, AdvancedMarks#Yank#Arguments(<f-args>)) | echoerr ingo#err#Get() | endif
command! -bar -range=% -nargs=* YankMarkRangesByMark
\ if ! AdvancedMarks#Yank#Ranges(function('AdvancedMarks#Yank#FilterMarks'), <line1>, <line2>, AdvancedMarks#Yank#Arguments(<f-args>)) | echoerr ingo#err#Get() | endif
command! -bar -range=% -nargs=* YankMarkRangesByLines
\ if ! AdvancedMarks#Yank#Ranges(function('AdvancedMarks#Reorder#GetMarksInOrder'), <line1>, <line2>, AdvancedMarks#Yank#Arguments(<f-args>)) | echoerr ingo#err#Get() | endif

command! -bar -range=% -nargs=* ReorderMarks
\ if ! AdvancedMarks#Reorder#Command(<line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -nargs=1 SetMarks if ! AdvancedMarks#Set#Marks(0, <q-args>) | echoerr ingo#err#Get() | endif
command! -bang -nargs=1 SetMARKS if ! AdvancedMarks#Set#Marks(1, <q-args>) | echoerr ingo#err#Get() | endif

command! -bar -bang -nargs=? Delmarks if ! AdvancedMarks#Delete#Marks(<bang>0, <q-args>) | echoerr ingo#err#Get() | endif

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
