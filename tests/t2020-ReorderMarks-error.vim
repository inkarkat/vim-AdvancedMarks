" Test errors when reordering marks.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(6)

call vimtap#err#Errors('No marks found', '21,29ReorderMarks', 'reorder marks where none are set')

echo 'Reordering where marks are already alphabetically ordered'
25,35ReorderMarks

echo 'Reordering in same order'
10,15ReorderMarks bdac

call vimtap#err#Errors('Invalid mark range: -z', 'ReorderMarks -z', 'bad mark range -z')
call vimtap#err#Errors('Invalid mark range: a-Z', 'ReorderMarks a-Z', 'bad mark range a-Z')
call vimtap#err#Errors('Invalid mark range: X-y', 'ReorderMarks abcX-yz', 'bad mark range X-y')
call vimtap#err#Errors('Invalid mark range: g-b', 'ReorderMarks abcg-bz', 'bad mark range g-b')
call vimtap#err#Errors('Invalid mark range: -Z', 'ReorderMarks a-z-Z', 'bad mark range -Z')

call vimtest#Quit()
