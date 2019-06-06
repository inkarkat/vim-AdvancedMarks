" Test errors when yanking marked lines in alphabetical mark order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(8)

call vimtap#err#Errors('Too many arguments', 'YankMarksByLines abc x and more', 'additional arguments')
call vimtap#err#Errors('Invalid mark range: -z', 'YankMarksByLines -z', 'bad mark range -z')
call vimtap#err#Errors('Invalid mark range: a-Z', 'YankMarksByLines a-Z', 'bad mark range a-Z')
call vimtap#err#Errors('Invalid mark range: X-y', 'YankMarksByLines abcX-yz', 'bad mark range X-y')
call vimtap#err#Errors('Invalid mark range: g-b', 'YankMarksByLines abcg-bz', 'bad mark range g-b')
call vimtap#err#Errors('Invalid mark range: -Z', 'YankMarksByLines a-z-Z', 'bad mark range -Z')

let @" = 'original'
call vimtap#err#Errors('No marks found', '21,29YankMarksByLines', 'yank all lowercase marks where none are set')
call vimtap#Is(@", 'original', 'default register contents are kept')

call vimtest#Quit()
