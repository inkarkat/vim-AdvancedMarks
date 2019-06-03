" Test errors when yanking marked ranges in line order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(3)

call vimtap#err#Throws('Too many arguments', 'YankMarkRangesByLines abc x and more', 'additional arguments')

let @" = 'original'
call vimtap#err#Throws('No mark ranges found', '21,29YankMarkRangesByLines', 'yank all lowercase marks where none are set')
call vimtap#Is(@", 'original', 'default register contents are kept')

call vimtest#Quit()
