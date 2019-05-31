" Test yanking of marked lines in alphabetical mark order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(5)

YankMarksByMark
call vimtap#Is(@", "13\n10\n14\n11\n3\n4\n4\n20\n18\n30\n31\n32\n", 'yank all lowercase marks')

10,20YankMarksByMark
call vimtap#Is(@", "13\n10\n14\n11\n20\n18\n", 'yank lowercase marks within 10,20')

YankMarksByMark zyjkab
call vimtap#Is(@", "32\n31\n20\n18\n13\n10\n", 'yank passed lowercase marks')

1,10YankMarksByMark bdefgh
call vimtap#Is(@", "10\n3\n4\n4\n", 'yank passed lowercase marks within 1,10')

YankMarksByMark AZDazd
call vimtap#Is(@", "2\n40\n8\n13\n32\n11\n", 'yank passed uppercase and lowercase marks')

call vimtest#Quit()
