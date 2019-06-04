" Test reordering of marks in the passed order.

call vimtest#StartTap()
call vimtap#Plan(10)

call SetMarks()
ReorderMarks zyxwvutsrqponmlkjihgfedcba
call IsPlacedMarks({'z': 3, 'y': 4, 'x': 4, 'k': 10, 'j': 11, 'g': 13, 'f': 14, 'e': 18, 'd': 20, 'c': 30, 'b': 31, 'a': 32}, 'reorder all lowercase marks in reverse')

call SetMarks()
10,20ReorderMarks zyxwvutsrqponmlkjihgfedcba
call IsPlacedMarks({'e': 3, 'f': 4, 'g': 4, 'x': 30, 'y': 31, 'z': 32}, 'reorder lowercase marks in reverse within 10,20 keeps marks outside range')
call IsPlacedMarks({'k': 10, 'j': 11, 'd': 13, 'c': 14, 'b': 18, 'a': 20}, 'reorder lowercase marks in reverse within 10,20 reorders marks in range')

call SetMarks()
ReorderMarks zyjkab
call IsPlacedMarks({'c': 14, 'd': 11, 'e': 3, 'f': 4, 'g': 4, 'x': 30}, 'reorder passed marks keeps other marks')
call IsPlacedMarks({'z': 10, 'y': 13, 'j': 18, 'k': 20, 'a': 31, 'b': 32}, 'reorder passed marks reorders passed marks in passed order')

call SetMarks()
1,10ReorderMarks hdegfb
call IsPlacedMarks({'a': 13, 'c': 14, 'j': 20, 'k': 18, 'x': 30, 'y': 31, 'z': 32}, 'reorder passed marks within 1,10 keeps other marks')
call IsPlacedMarks({'d': 11}, 'reorder passed marks within 1,10 reorders keeps marks outside range')
call IsPlacedMarks({'e': 3, 'g': 4, 'f': 4, 'b': 10}, 'reorder passed marks within 1,10 reorders passed marks in passed order')

call SetMarks()
ReorderMarks AZDazd
call IsPlacedMarks({'E': 7, 'F': 4, 'X': 36, 'b': 10, 'c': 14, 'e': 3, 'f': 4, 'g': 4, 'x': 30, 'y': 31}, 'reorder passed uppercase and lowercase marks keeps other marks')
call IsPlacedMarks({'A': 2, 'Z': 8, 'D': 11, 'a': 13, 'z': 32, 'd': 40}, 'reorder passed uppercase and lowercase marks reorders passed marks in passed order')

call vimtest#Quit()
