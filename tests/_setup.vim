call vimtest#AddDependency('vim-ingo-library')

runtime plugin/AdvancedMarks.vim

function! SetMarks() abort
    call append(0, range(1, 40))
    2mark A
    3mark e
    4mark f
    4mark g
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
