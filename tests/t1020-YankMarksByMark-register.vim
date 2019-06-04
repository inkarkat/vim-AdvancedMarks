" Test yanking of marked lines in alphabetical mark order into a register.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(5)

YankMarksByMark "
call IsYankedLnums('13 10 14 11 3 4 4 20 18 30 31 32', 'yank all lowercase marks into explicit default register')

let @" = 'original'
YankMarksByMark x
call IsYankedLnums(@x, '13 10 14 11 3 4 4 20 18 30 31 32', 'yank all lowercase marks into passed register')
call vimtap#Is(@", 'original', 'default register is not modified')

let @" = 'original'
1,10YankMarksByMark bdefgh x
call IsYankedLnums(@x, '10 3 4 4', 'yank passed lowercase marks within 1,10 into passed register')
call vimtap#Is(@", 'original', 'default register is not modified')

call vimtest#Quit()
