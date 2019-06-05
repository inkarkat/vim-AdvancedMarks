" Test running out of available lowercase marks.

call SetMarks()
call append(40, 'mamemimomukakekikokunaneninonugagegigogu')
call vimtest#StartTap()
call vimtap#Plan(6)

SetMarks 41:1 41:3 41:5 41:7 41:9 41:11 41:13 41:15 41:17 41:19 41:21 41:23 41:25
call IsPlacedMarks({'v': [41, 25], 'x': 30, 'y': 31, 'z': 32}, 'last set mark is v')

call vimtap#err#Errors('Ran out of marks; 1 location not marked.', 'SetMarks 41:27 41:29', 'try setting two more marks while only one is available')
call IsPlacedMarks({'w': [41, 27]}, '')

call vimtap#err#Errors('Ran out of marks; 3 locations not marked.', 'SetMarks 41:31 41:32 41:33', 'try setting three marks with none available')

call vimtap#err#Errors('Ran out of marks; 4 locations not marked.', 'SetMARKS 41:1 41:2 41:3 41:4 41:5 41:6 41:7 41:8 41:9 41:10 41:11 41:12 41:13 41:14 41:15 41:16 41:17 41:18 41:19 41:20 41:21 41:22 41:23 41:24', 'try setting a lot of uppercase marks')
call IsPlacedMarks({'V': [41, 18], 'W': [41, 19], 'X': 36, 'Y': [41, 20], 'Z': 40}, 'last set marks are V, W, Y')

call vimtest#Quit()
