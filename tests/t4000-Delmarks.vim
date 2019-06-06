" Test deleting all marks in the current buffer.

call SetMarksInBuffers()

call vimtest#StartTap()
call vimtap#Plan(4)

Delmarks

call vimtap#err#ErrorsLike('^E283:', 'marks abcdefghijklmnopqrstuvwxyz', 'no lowercase marks defined in current buffer')
call vimtap#err#ErrorsLike('^E283:', 'marks ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'no uppercase marks defined in current buffer')
wincmd w
call IsPlacedMarks({'i': 31, 'w': 22}, 'lowercase marks still defined in other buffer')
call vimtap#err#ErrorsLike('^E283:', 'marks ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'no uppercase marks defined in other buffer')

call vimtest#Quit()
