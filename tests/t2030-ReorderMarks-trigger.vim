" Test triggering reorder event.

let s:isTriggered = 0
autocmd User MarksUpdated let s:isTriggered = 1

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(3)

21,29ReorderMarks
call vimtap#Ok(! s:isTriggered, 'Reordering where no marks are set does not trigger')

25,35ReorderMarks
call vimtap#Ok(! s:isTriggered, 'Reordering where marks are already alphabetically ordered does not trigger')

1,10ReorderMarks
call vimtap#Ok(s:isTriggered, 'Reordering existing unordered marks triggers')

call vimtest#Quit()
