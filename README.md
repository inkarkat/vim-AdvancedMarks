ADVANCED MARKS
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

This plugin extends Vim's built-in mark handling. The :mark command can only
set lines; with :SetMarks, you can also pass a column. :Delmarks is an
extension of|:delmarks| that defaults to all marks and can wipe lowercase
marks in all buffers and uppercase marks also from the viminfo file (to keep
them from reappearing after a Vim restart).
If you use marks as bookmarks for interesting areas in a buffer, new commands
let you yank the marked lines (:YankMarks) or ranges (:YankMarkRanges,
using 'a to 'A, 'b to 'B, and so on). There are variants for ordering the
yanks by marks or lines. A separate :ReorderMarks command lets you reorder
messed up marks (e.g. if you forget setting a mark in the middle of a buffer).

### SOURCE

- :YankMarks is inspiration http://stackoverflow.com/a/16314609/813602

USAGE
------------------------------------------------------------------------------

    :SetMarks {lnum[:col]} [...]
                            Set available lowercase marks to the passed lines [and
                            virtual column]. The numbers can be separated by any
                            text.
    :SetMARKS {lnum[:col]} [...]
                            Like :SetMarks, but use global uppercase marks.

    :Delmarks[!]            Delete all named marks a-z (current buffer, with [!]
                            in all buffers) and global file marks A-Z (with [!]
                            also in the viminfo file).
    :Delmarks[!] {marks}    Delete {marks}, with [!] lowercase ones in all
                            buffers, and uppercase ones also in the viminfo
                            file.

    :[range]ReorderMarks [{marks}] [{order-expression}]
                            Reorder [a-z] / {marks} marks alphabetically / in the
                            order of given {marks} / ascending based on the value
                            returned by {order-expression} (which is evaluated
                            once on each marked line) from begin to end of the
                            buffer.

    :[range]YankMarksByMark [{marks}] [{register}]
                            Yank all marked (with [a-z] / {marks} marks) lines
                            into the default register / {register} (in the order
                            of the marks, default alphabetically or as given).
    :[range]YankMarksByLines [{marks}] [{register}]
                            Same as :YankMarksByMark, but yank marks from begin to
                            end of the buffer.

    :[range]YankMarkRangesByMark [{marks}] [{register}]
                            Yank all ranges of lines that start with a lowercase
                            [a-z] / {marks} mark and end with the corresponding
                            uppercase [A-Z] mark in the current buffer into the
                            default register / {register} (in the order of the
                            marks).
    :[range]YankMarkRangesByLines [{marks}] [{register}]
                            Same as :YankMarkRangesByMark, but yank marks from
                            begin to end of the buffer.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at https://github.com/inkarkat/vim-AdvancedMarks
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim AdvancedMarks*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.038 or
  higher.
- Requires the ArgsAndMore.vim plugin ([vimscript #4152](http://www.vim.org/scripts/script.php?script_id=4152)), version 2.11 or
  higher (only for :Delmarks! deletion in all buffers).

INTEGRATION
------------------------------------------------------------------------------

- :ReorderMarks issues a MarksUpdated User event. A plugin that displays
  marks (e.g. via signs, like ShowMarks.vim) can be triggered by this to
  update the marks.

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-AdvancedMarks/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### 1.00    09-Jun-2019
- First published version.

##### 0.01    01-May-2013
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2013-2019 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
