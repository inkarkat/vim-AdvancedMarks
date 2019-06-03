" Test yanking of marked lines in alphabetical mark order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(5)

YankMarksByMark
call IsYankedLnums('13 10 14 11 3 4 4 20 18 30 31 32', 'yank all lowercase marks')

10,20YankMarksByMark
call IsYankedLnums('13 10 14 11 20 18', 'yank lowercase marks within 10,20')

YankMarksByMark zyjkab
call IsYankedLnums('32 31 20 18 13 10', 'yank passed lowercase marks')

1,10YankMarksByMark bdefgh
call IsYankedLnums('10 3 4 4', 'yank passed lowercase marks within 1,10')

YankMarksByMark AZDazd
call IsYankedLnums('2 40 8 13 32 11', 'yank passed uppercase and lowercase marks')

call vimtest#Quit()
