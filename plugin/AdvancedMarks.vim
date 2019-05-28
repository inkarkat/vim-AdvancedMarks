" AdvancedMarks.vim: Work with marks with more power.
"
" DEPENDENCIES:
"   - AdvancedMarks/*.vim autoload scripts
"   - ingo/err.vim autoload script
"
" Copyright: (C) 2013-2017 Ingo Karkat
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

command! -bar -nargs=* YankMarks      call AdvancedMarks#Yank#Marks (AdvancedMarks#Yank#Arguments(<f-args>))
command! -bar -nargs=* YankMarkRanges call AdvancedMarks#Yank#Ranges(AdvancedMarks#Yank#Arguments(<f-args>))

command! -bang -nargs=1 SetMarks if ! AdvancedMarks#Set#Marks(0, <q-args>) | echoerr ingo#err#Get() | endif
command! -bang -nargs=1 SetMARKS if ! AdvancedMarks#Set#Marks(1, <q-args>) | echoerr ingo#err#Get() | endif

command! -bar -bang -nargs=? Delmarks if ! AdvancedMarks#Delete#Marks(<bang>0, <q-args>) | echoerr ingo#err#Get() | endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
