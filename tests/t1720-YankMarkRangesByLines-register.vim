" Test yanking of marked ranges in line order into a register.

call SetMarks()
15mark A

let s:rangeA = '13 14 15'
let s:rangeE = '3 4 5 6 7'
let s:rangeF = '4'
let s:rangeX = '30 31 32 33 34 35 36'
let s:rangeZ = '32 33 34 35 36 37 38 39 40'

call vimtest#StartTap()
call vimtap#Plan(5)

YankMarkRangesByLines "
call IsYankedLnums(join([s:rangeE, s:rangeF, s:rangeA, s:rangeX, s:rangeZ]), 'yank all lower-upper ranges into explicit default register')

let @" = 'original'
YankMarkRangesByLines x
call IsYankedLnums(@x, join([s:rangeE, s:rangeF, s:rangeA, s:rangeX, s:rangeZ]), 'yank all lower-upper ranges into passed register')
call vimtap#Is(@", 'original', 'default register contents are kept')

let @" = 'original'
30,40YankMarkRangesByLines xe x
call IsYankedLnums(@x, s:rangeX, 'yank passed lowercase mark ranges within 30,40 into passed register')
call vimtap#Is(@", 'original', 'default register contents are kept')

call vimtest#Quit()
