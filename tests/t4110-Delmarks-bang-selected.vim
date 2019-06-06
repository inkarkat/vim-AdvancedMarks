" Test deleting passed marks in all buffers.

call SetMarksInBuffers()

call vimtest#StartTap()
call vimtap#Plan(5)

Delmarks! abcdf-mC-Z
call IsPlacedMarks({'e': 3, 'x': 30, 'y': 31, 'z': 32, 'A': 2}, 'other marks still defined in current buffer')
call vimtap#err#ErrorsLike('^E283:', 'marks abcdfghijklm', 'no passed lowercase marks defined in current buffer')
call vimtap#err#ErrorsLike('^E283:', 'marks CDEFGHIJKLMNOPQRSTUVWXYZ', 'no passed uppercase marks defined in current buffer')
wincmd w
call vimtap#err#ErrorsLike('^E283:', 'marks abcdfghijklm', 'no passed lowercase marks defined in other buffer')
call vimtap#err#ErrorsLike('^E283:', 'marks CDEFGHIJKLMNOPQRSTUVWXYZ', 'no passed uppercase marks defined in other buffer')

call vimtest#Quit()
