" Test reordering of mark ranges.

call vimtest#StartTap()
call vimtap#Plan(10)

call SetMarks()
ReorderMarks abi-lyz
call IsPlacedMarks({'c': 14, 'd': 11, 'e': 3, 'f': 4, 'g': 4, 'x': 30}, 'reorder passed marks keeps other marks')
call IsPlacedMarks({'a': 10, 'b': 13, 'j': 18, 'k': 20, 'y': 31, 'z': 32}, 'reorder passed marks reorders passed marks')

call SetMarks()
1,10ReorderMarks b-h
call IsPlacedMarks({'a': 13, 'c': 14, 'j': 20, 'k': 18, 'x': 30, 'y': 31, 'z': 32}, 'reorder passed marks within 1,10 keeps other marks')
call IsPlacedMarks({'d': 11}, 'reorder passed marks within 1,10 reorders keeps marks outside range')
call IsPlacedMarks({'b': 3, 'e': 4, 'f': 4, 'g': 10}, 'reorder passed marks within 1,10 reorders passed marks')

call SetMarks()
1,10ReorderMarks hd-fb
call IsPlacedMarks({'a': 13, 'c': 14, 'j': 20, 'k': 18, 'x': 30, 'y': 31, 'z': 32}, 'reorder passed marks within 1,10 keeps other marks')
call IsPlacedMarks({'d': 11}, 'reorder passed marks within 1,10 reorders keeps marks outside range')
call IsPlacedMarks({'e': 3, 'g': 4, 'f': 4, 'b': 10}, 'reorder passed marks within 1,10 reorders passed marks in passed order')

call SetMarks()
ReorderMarks A-Fadz
call IsPlacedMarks({'X': 36, 'Z': 40, 'b': 10, 'c': 14, 'e': 3, 'f': 4, 'g': 4, 'x': 30, 'y': 31}, 'reorder passed uppercase and lowercase marks keeps other marks')
call IsPlacedMarks({'A': 2, 'D': 4, 'E': 7, 'F': 8, 'a': 11, 'd': 13, 'z': 32}, 'reorder passed uppercase and lowercase marks reorders passed marks')

call vimtest#Quit()
