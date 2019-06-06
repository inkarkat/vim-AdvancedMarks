" Test deleting all marks in all buffers.

call SetMarksInBuffers()

call vimtest#StartTap()
call vimtap#Plan(4)

Delmarks!

call vimtap#err#ErrorsLike('^E283:', 'marks abcdefghijklmnopqrstuvwxyz', 'no lowercase marks defined in current buffer')
call vimtap#err#ErrorsLike('^E283:', 'marks ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'no uppercase marks defined in current buffer')
wincmd w
call vimtap#err#ErrorsLike('^E283:', 'marks abcdefghijklmnopqrstuvwxyz', 'no lowercase marks defined in other buffer')
call vimtap#err#ErrorsLike('^E283:', 'marks ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'no uppercase marks defined in other buffer')

call vimtest#Quit()
