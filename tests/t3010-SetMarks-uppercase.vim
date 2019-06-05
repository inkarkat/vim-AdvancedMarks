" Test setting uppercase marks to passed positions.

call SetMarks()
let s:placedMarks = {'A': 2, 'D': 8, 'E': 7, 'F': 4, 'X': 36, 'Z': 40}

call vimtest#StartTap()
call vimtap#Plan(2)

SetMARKS 5
call extend(s:placedMarks, {'B': 5})
call IsPlacedMarks(s:placedMarks, 'first available mark is B')

SetMARKS 31 15:2 21:2
call extend(s:placedMarks, {'C': 31, 'G': [15, 2], 'H': [21, 2]})
call IsPlacedMarks(s:placedMarks, 'set both line and column')

call vimtest#Quit()
