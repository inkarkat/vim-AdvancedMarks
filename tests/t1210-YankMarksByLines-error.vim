" Test errors when yanking marked lines in alphabetical mark order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(3)

call vimtap#err#Throws('Too many arguments', 'YankMarksByLines abc x and more', 'additional arguments')

let @" = 'original'
call vimtap#err#Throws('No marks found', '21,29YankMarksByLines', 'yank all lowercase marks where none are set')
call vimtap#Is(@", 'original', 'default register contents are kept')

call vimtest#Quit()
