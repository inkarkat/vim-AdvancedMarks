" Test yanking of marked lines in line order.

call SetMarks()
call vimtest#StartTap()
call vimtap#Plan(5)

YankMarksByLines
call vimtap#Is(@", "3\n4\n4\n10\n11\n13\n14\n18\n20\n30\n31\n32\n", 'yank all lowercase marks')

10,20YankMarksByLines
call vimtap#Is(@", "10\n11\n13\n14\n18\n20\n", 'yank lowercase marks within 10,20')

YankMarksByLines zyjkab
call vimtap#Is(@", "10\n13\n18\n20\n31\n32\n", 'yank passed lowercase marks')

1,10YankMarksByLines bdefgh
call vimtap#Is(@", "3\n4\n4\n10\n", 'yank passed lowercase marks within 1,10')

YankMarksByLines AZDazd
call vimtap#Is(@", "2\n8\n11\n13\n32\n40\n", 'yank passed uppercase and lowercase marks')

call vimtest#Quit()
