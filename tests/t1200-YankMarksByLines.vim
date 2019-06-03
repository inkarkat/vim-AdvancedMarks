" Test yanking of marked lines in line order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(5)

YankMarksByLines
call IsYankedLnums('3 4 4 10 11 13 14 18 20 30 31 32', 'yank all lowercase marks')

10,20YankMarksByLines
call IsYankedLnums('10 11 13 14 18 20', 'yank lowercase marks within 10,20')

YankMarksByLines zyjkab
call IsYankedLnums('10 13 18 20 31 32', 'yank passed lowercase marks')

1,10YankMarksByLines bdefgh
call IsYankedLnums('3 4 4 10', 'yank passed lowercase marks within 1,10')

YankMarksByLines AZDazd
call IsYankedLnums('2 8 11 13 32 40', 'yank passed uppercase and lowercase marks')

call vimtest#Quit()
