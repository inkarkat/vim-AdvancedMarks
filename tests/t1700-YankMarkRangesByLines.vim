" Test yanking of marked ranges in line order.

call SetMarks()
15mark A

let s:rangeA = '13 14 15'
let s:rangeE = '3 4 5 6 7'
let s:rangeF = '4'
let s:rangeX = '30 31 32 33 34 35 36'
let s:rangeZ = '32 33 34 35 36 37 38 39 40'

call vimtest#StartTap()
call vimtap#Plan(5)

YankMarkRangesByLines
call IsYankedLnums(join([s:rangeE, s:rangeF, s:rangeA, s:rangeX, s:rangeZ]), 'yank all lower-upper ranges')

30,40YankMarkRangesByLines
call IsYankedLnums(join([s:rangeX, s:rangeZ]), 'yank lower-upper ranges within 30,40')

YankMarkRangesByLines xe
call IsYankedLnums(join([s:rangeE, s:rangeX]), 'yank passed lowercase mark ranges')

30,40YankMarkRangesByLines xe
call IsYankedLnums(s:rangeX, 'yank passed lowercase mark ranges within 30,40')

YankMarkRangesByLines XzeE
call IsYankedLnums(join([s:rangeE, s:rangeZ]), 'yank only lowercase, not passed uppercase mark ranges')

call vimtest#Quit()
