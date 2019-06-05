" Test settting mark to position with existing mark.

edit example.txt
delmarks a-zA-Z
let s:placedMarks = {}

call vimtest#StartTap()
call vimtap#Plan(6)

SetMarks 7
call extend(s:placedMarks, {'a': 7})
call IsPlacedMarks(s:placedMarks, 'first available mark is a')

SetMarks 7
SetMarks 9:8
call extend(s:placedMarks, {'b': [9, 8]})
call IsPlacedMarks(s:placedMarks, 'next available mark still is b')

SetMarks 9:8
SetMarks 9:8 7 10:4
call extend(s:placedMarks, {'c': [10, 4]})
call IsPlacedMarks(s:placedMarks, 'next available mark still is c')

SetMarks 10:3 10:5
call extend(s:placedMarks, {'d': [10, 3], 'e': [10, 5]})
call IsPlacedMarks(s:placedMarks, 'new marks are created around existing mark c')

SetMARKS 9:8
call extend(s:placedMarks, {'A': [9, 8]})
call IsPlacedMarks(s:placedMarks, 'first uppercase mark A does not interfere with existing lowercase mark b')

SetMARKS 9:8
SetMARKS 9:8 16:3
call extend(s:placedMarks, {'B': [16, 3]})
call IsPlacedMarks(s:placedMarks, 'next available uppercase mark still is B')

call vimtest#Quit()
