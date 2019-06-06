" Test errors when yanking marked ranges in alphabetical mark order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(8)

call vimtap#err#Errors('Too many arguments', 'YankMarkRangesByMark abc x and more', 'additional arguments')
call vimtap#err#Errors('Invalid mark range: -z', 'YankMarkRangesByMark -z', 'bad mark range -z')
call vimtap#err#Errors('Invalid mark range: a-Z', 'YankMarkRangesByMark a-Z', 'bad mark range a-Z')
call vimtap#err#Errors('Invalid mark range: X-y', 'YankMarkRangesByMark abcX-yz', 'bad mark range X-y')
call vimtap#err#Errors('Invalid mark range: g-b', 'YankMarkRangesByMark abcg-bz', 'bad mark range g-b')
call vimtap#err#Errors('Invalid mark range: -Z', 'YankMarkRangesByMark a-z-Z', 'bad mark range -Z')

let @" = 'original'
call vimtap#err#Errors('No mark ranges found', '21,29YankMarkRangesByMark', 'yank all lowercase marks where none are set')
call vimtap#Is(@", 'original', 'default register contents are kept')

call vimtest#Quit()
