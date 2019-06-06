" Test yanking of marked mark ranges in alphabetical mark order.

call SetMarks()

let s:rangeE = '3 4 5 6 7'
let s:rangeF = '4'

call vimtest#StartTap()
call vimtap#Plan(1)

YankMarkRangesByMark a-f
call IsYankedLnums(join([s:rangeE, s:rangeF]), 'yank passed lowercase mark ranges')

call vimtest#Quit()
