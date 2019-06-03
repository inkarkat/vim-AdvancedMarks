" Test yanking of marked ranges in alphabetical mark order.

call SetMarks()

let s:rangeE = '3 4 5 6 7'
let s:rangeF = '4'
let s:rangeX = '30 31 32 33 34 35 36'
let s:rangeZ = '32 33 34 35 36 37 38 39 40'

call vimtest#StartTap()
call vimtap#Plan(5)

YankMarkRangesByMark
call IsYankedLnums(join([s:rangeE, s:rangeF, s:rangeX, s:rangeZ]), 'yank all lower-upper ranges')

30,40YankMarkRangesByMark
call IsYankedLnums(join([s:rangeX, s:rangeZ]), 'yank lower-upper ranges within 30,40')

YankMarkRangesByMark xe
call IsYankedLnums(join([s:rangeX, s:rangeE]), 'yank passed lowercase mark ranges')

30,40YankMarkRangesByMark xe
call IsYankedLnums(s:rangeX, 'yank passed lowercase mark ranges within 30,40')

YankMarkRangesByMark XzeE
call IsYankedLnums(join([s:rangeZ, s:rangeE]), 'yank only lowercase, not passed uppercase mark ranges')

call vimtest#Quit()
