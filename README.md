RANGE MACRO
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

Macros are a fantastic way to apply the same modification many many times.
Just record once and then repeat, repeat, repeat...

Though it's easy to repeat (@@, [count]@{0-9a-z".=\*}) a macro, explicit
repeating becomes cumbersome when you're dealing with hundreds of repeats. You
can write a recursive macro (i.e. invoking the macro at the end), but that
will execute over the entire buffer, until the macro errors out on the border
of the buffer. Simple macros that mostly restrict themselves to a single line
can be repeated via :[range]normal @{0-9a-z".=\*}, but that breaks when lines
are inserted or removed, or the macro jumps to other lines.

What's needed for extensive macro repetitions is to repeatedly execute the
macro over a range, and stop once the macro navigates out of the range.

This plugin provides a :RangeMacro command and mappings that execute a
recorded macro over a range, area of text covered by {motion}, or the current
seletion.

### RELATED WORKS

- CommandWithMutableRange.vim ([vimscript #3270](http://www.vim.org/scripts/script.php?script_id=3270)) executes commands which may
  add or remove lines for each line in the range.

USAGE
------------------------------------------------------------------------------

    :[range]RangeMacro {0-9a-z".*+}
                            Position the cursor on the first column of the start
                            of [range] and execute the contents of register
                            {0-9a-z".*+} repeatedly until the cursor moves beyond
                            the lines covered by [range].

    <Leader>@{0-9a-z".*+}{motion}
                            Repeatedly execute the contents of register
                            {0-9a-z".*+} until the cursor moves outside the text
                            covered by {motion}.

    {Visual}<Leader>@{0-9a-z".*+}
                            Position the cursor on the first column of the
                            selection and execute the contents of register
                            {0-9a-z".*+} repeatedly until the cursor moves outside
                            the selection. All selection modes are supported:
                            characterwise, linewise and blockwise.

    Note: The check whether the macro moved outside the range is only done _after_
    each macro invocation. During macro evaluation, jumps outside the range can be
    used and will not stop macro execution.

### SUITABLE MACROS

    To make a macro repeatable, the macro must move to the position where the next
    macro call needs to take place, typically either as the first or last command
    of the macro. The macro will always be executed from top to bottom of the
    range, regardless of how {motion} or the selection was made.
    So, for example, if the macro processes line(s) sequentially, append the "j"
    command to move to the next line; if the buffer areas are located via
    searching, you could use the "n" command to move to the next match.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-RangeMacro
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim RangeMacro*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.037 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

As there must be mappings for all supported registers, the mapping cannot be
easily customized via the &lt;Plug&gt; mechanism. Instead, if you prefer a different
mapping, redefine the start of the normal and visual mode mappings (before
the plugin is sourced):

    let g:RangeMacro_Mapping = '<Leader>@'

TODO
------------------------------------------------------------------------------

- Capture original range and number of iterations to show "3 macro iterations,
  3 new lines"
- Support register = (by querying for an expression and executing that).

### IDEAS

- Check whether position or line contents at last position have changed versus
  last run to break endless loop?

### CONTRIBUTING

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-RangeMacro/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### 1.01    RELEASEME
- Add dependency to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)).

##### 1.00    07-Oct-2010
- First published version.

##### 0.01    29-Sep-2010
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2010-2022 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
