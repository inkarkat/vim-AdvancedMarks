" Test yanking of mark ranges in alphabetical mark order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(2)

YankMarksByMark a-bkl-y
call IsYankedLnums('13 10 18 30 31', 'yank passed lowercase mark ranges')

YankMarksByMark c-cA-Ge-g x
call IsYankedLnums(@x, '14 2 8 7 4 3 4 4', 'yank passed uppercase and lowercase mark ranges')

call vimtest#Quit()
