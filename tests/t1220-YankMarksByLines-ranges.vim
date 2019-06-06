" Test yanking of mark ranges.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(2)

YankMarksByLines a-bkl-y
call IsYankedLnums('10 13 18 30 31', 'yank passed lowercase mark ranges')

YankMarksByLines c-cA-Ge-g x
call IsYankedLnums(@x, '2 3 4 4 4 7 8 14', 'yank passed uppercase and lowercase mark ranges')

call vimtest#Quit()
