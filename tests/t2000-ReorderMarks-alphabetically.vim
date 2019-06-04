" Test reordering of marks alphabetially.

call vimtest#StartTap()
call vimtap#Plan(10)

call SetMarks()
ReorderMarks
call IsPlacedMarks({'a': 3, 'b': 4, 'c': 4, 'd': 10, 'e': 11, 'f': 13, 'g': 14, 'j': 18, 'k': 20, 'x': 30, 'y': 31, 'z': 32}, 'reorder all lowercase marks')

call SetMarks()
10,20ReorderMarks
call IsPlacedMarks({'e': 3, 'f': 4, 'g': 4, 'x': 30, 'y': 31, 'z': 32}, 'reorder lowercase marks within 10,20 keeps marks outside range')
call IsPlacedMarks({'a': 10, 'b': 11, 'c': 13, 'd': 14, 'j': 18, 'k': 20}, 'reorder lowercase marks within 10,20 reorders marks in range')

call SetMarks()
ReorderMarks abjkyz
call IsPlacedMarks({'c': 14, 'd': 11, 'e': 3, 'f': 4, 'g': 4, 'x': 30}, 'reorder passed marks keeps other marks')
call IsPlacedMarks({'a': 10, 'b': 13, 'j': 18, 'k': 20, 'y': 31, 'z': 32}, 'reorder passed marks reorders passed marks')

call SetMarks()
1,10ReorderMarks bdefgh
call IsPlacedMarks({'a': 13, 'c': 14, 'j': 20, 'k': 18, 'x': 30, 'y': 31, 'z': 32}, 'reorder passed marks within 1,10 keeps other marks')
call IsPlacedMarks({'d': 11}, 'reorder passed marks within 1,10 reorders keeps marks outside range')
call IsPlacedMarks({'b': 3, 'e': 4, 'f': 4, 'g': 10}, 'reorder passed marks within 1,10 reorders passed marks')

call SetMarks()
ReorderMarks ADZadz
call IsPlacedMarks({'E': 7, 'F': 4, 'X': 36, 'b': 10, 'c': 14, 'e': 3, 'f': 4, 'g': 4, 'x': 30, 'y': 31}, 'reorder passed uppercase and lowercase marks keeps other marks')
call IsPlacedMarks({'A': 2, 'D': 8, 'Z': 11, 'a': 13, 'd': 32, 'z': 40}, 'reorder passed uppercase and lowercase marks reorders passed marks')

call vimtest#Quit()
