call vimtest#AddDependency('vim-ingo-library')

runtime plugin/AdvancedMarks.vim

function! SetMarks() abort
    if ingo#buffer#IsEmpty()
	call append(0, range(1, 40))
    endif

    2mark A
    3mark e
    4mark f
    4mark g
    4mark F
    7mark E
    8mark D
    10mark b
    11mark d
    13mark a
    14mark c
    18mark k
    20mark j
    30mark x
    31mark y
    32mark z
    36mark X
    40mark Z
endfunction

function! IsYankedLnums( ... ) abort
    let [l:register, l:lnums, l:description] = (a:0 == 2 ? [@"] + a:000 : a:000)
    call vimtap#Is(l:register, join(split(l:lnums, ' ') + [''], "\n"), l:description)
endfunction

function! IsPlacedMarks( markedPlaces, description ) abort
    let l:marks = keys(a:markedPlaces)
    let l:actual = ingo#dict#FromItems(map(l:marks, '[v:val, line("''" . v:val)]'))
    call vimtap#Is(l:actual, a:markedPlaces, a:description)
endfunction
