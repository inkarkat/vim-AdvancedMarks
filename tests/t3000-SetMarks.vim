" Test setting lowercase marks to passed positions.

edit example.txt
delmarks a-zA-Z
let s:placedMarks = {}

call vimtest#StartTap()
call vimtap#Plan(5)

SetMarks 7
call extend(s:placedMarks, {'a': 7})
call IsPlacedMarks(s:placedMarks, 'first available mark is a')

SetMarks 5
call extend(s:placedMarks, {'b': 5})
call IsPlacedMarks(s:placedMarks, 'second available mark is b')

SetMarks 14 12 13
call extend(s:placedMarks, {'c': 14, 'd': 12, 'e': 13})
call IsPlacedMarks(s:placedMarks, 'set three marks at once')

SetMarks 5:10
call extend(s:placedMarks, {'f': [5, 10]})
call IsPlacedMarks(s:placedMarks, 'set both line and column')

SetMarks 31 5:23 21:31
call extend(s:placedMarks, {'g': 31, 'h': [5, 23], 'i': [21, 31]})
call IsPlacedMarks(s:placedMarks, 'set both line and column')

call vimtest#Quit()
