" Test setting mark to invalid locations.

edit example.txt
delmarks a-zA-Z

call vimtest#StartTap()
call vimtap#Plan(2)

SetMarks 9:8 9:99 9:13 10:6 10:30
call IsPlacedMarks({'a': [9, 8], 'b': [9, 14], 'c': [9, 13], 'd': [10, 6], 'e': [10, 30]}, 'all marks set, but b truncated to just beyond EOL')


SetMARKS 24:30 24:20 32 99:99
call IsPlacedMarks({'A': [24, 25], 'B': [24, 23], 'C': [32, 1], 'D': [99, 1]}, 'all uppercase marks set, but B truncated to just beyond EOL, and C + D with vcol 0')

call vimtest#Quit()
