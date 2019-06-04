" Test errors when reordering marks.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Throws('No marks found', '21,29ReorderMarks', 'reorder marks where none are set')

echo 'Reordering where marks are already alphabetically ordered'
25,35ReorderMarks

echo 'Reordering in same order'
10,15ReorderMarks bdac

call vimtest#Quit()
