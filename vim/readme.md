
# first things first

1. You start vim in **normal mode**. You cannot type text in normal mode. See the section about *editing actions* for typing text.
1. In normal mode most keys have a function: moving the cursor, switching mode, and much more...
1. You can quit vim when you're in normal mode by typing `ZQ` (does not save the file) or `ZZ` (saves the file)
1. There is a vim command line which is entered by typing `:`. But that's advanced stuff already


# keystroke notation

* `<C-a>` means `ctrl` + a
* `<S-tab>` means `shift`+tab. But for letters they are just capitalized...
* `<M-up>` means `meta` + up arrow. `meta` usually is the left-alt key.
* `<cr>` or `<CR>` is the enter key
* `<leader>` is `\` by default but it should be customized, it is used for user-defined shortcuts (and plugins). I'm currently using `,` as my leader key.

# motions
This is how to move the cursor around.

* simplest motions
  * `h` go left
  * `j` go down
  * `k` go up
  * `l` go right
* word based motions
  * `w` go to the first character of the next word
  * `e` go to the end of the current/next word
  * `b` go to the first character of the current/previous word
    * Note that punctuation are words by themselves.
  * `W`, `E`, `B` are the same but using white-space as the word delimiter
* find/till - in these example `x` can be any character
 * `fx` go to the next occurrence of `x` in the current line
 * `Fx` go to the previous occurrence of `x` in the current line
 * `tx` go to the character before next occurrence of `x` in the current line
 * `Tx` go to the character after previous occurrence of `x` in the current line
 * `;` to repeat the last find/till in the same direction
 * `,` to repeat the last find/till in the opposite direction
* inline motions
  * `0` go to the start of the line
  * `^` go to the first non-whitespace character of the line
  * `$` go to the end of the line
* line motions
  * `-` go to the first non-whitespace character of the previous line
  * `+` go to the first non-whitespace character of the next line
  * `<cr>` go to the first non-whitespace character of the next line

# jumps

* line jumps
  * `gg` go to the first line
  * `G` go the last line
  * `5gg` and `5G` both go the line number 5
* screen jumps
  * `H` go to the top of the screen
  * `M` go to the middle of the screen
  * `L` go to the bottom of the screen
  * `<C-u>` scroll half a screen up
  * `<C-d>` scroll half a screen down
* paragraph based jumps
  * `}` go one paragraph forward
  * `{` go tone paragraph backward
* search based jumps
  * `/pattern` Go to the next occurrence of the pattern in the file (loops back to the start of the file)
  * `?pattern` Go to the previous occurrence of the pattern (loops back to the end of the file)
  * `*` Go to the next occurrence of the word under the cursor
  * `#` Go to the previous occurrence of the word under the cursor
  * `n` repeat the last search
  * `N` repeat the last search in the opposite direction
* matching character jump
 * `%` goes the matching character of the `()`,`[]`, `{}` pairs.
* jump tree
  * `<C-o>` go to where you last jumped from (in the jump tree)
  * `<C-i>` go back to where you last jumped to (in the jump tree)

# editing actions

* start **insert mode**
  * `i` in front of the cursor
  * `a` after the cursor
  * `I` in front of the first non-whitespace character of the line, like `^i`
  * `A` at the end of the line, like `$a`
* repeat, undo, redo
  * `.` to repeat the last action
  * `u` to undo the last action in the action tree
  * `<C-r>` redo the next action in the action tree
* replace mode
  * `R`, like `i` but the text that you type replaces the existing text
* delete and change
  * `d{motion}` deletes the text inside the motion
  * `c{motion}` deletes the text inside the motion and starts insert mode
  * `D` and `C` deletes/changes the rest of the line
  * `dd` and `cc` deletes/changes the whole line
* copy and pasting
  * `y{motion}` yanks the text inside the motion, as in: puts it in a register
  * `p` pastes the text in the register after the cursor
  * `P` pastes the text in the register in front of the cursor
  * in insert mode `<C-r>"` inserts the text in the register
  * `Y` yanks the whole line
  * by the way the `d` and `c` commands also put the deleted text into the register
* character operations
  * `x` deletes the character under the cursor
  * `X` deletes the character in front of the cursor
  * `rx` replaces the character under the cursor by `x` (`x` could be any character)
  * `s` deletes the character under the cursor and start insert mode
  * `S` changes the whole like, like `cc`
* number operations
  * `<C-a>` increments the next number
  * `<C-x>` decrements the next number
* indentation operations
  * `>{motion}` increments the indentation of the lines inside the motion
  * `>>` increments the indentation of the current lines
  * `<{motion}` and `<<` do the opposite
* auto-completion in insert mode
  * `<C-n>` auto-complete using forward matches
  * `<C-p>` auto-complete using backward matches
* `<C-o>{action}` allows you to type in a normal mode action while in insert mode. It escapes the insert mode, executes the action and puts you back in insert mode.

when in insert mode you can switch back to normal mode by typing Esc`, `<C-c>` or `<C-[>`

# multiply motions and actions

Motions and actions can be multiplied: `2h` will go 2 times left, `10w` will go 10 words forward. `d5w` or `5dw` will both delete 5 words forward.

# macros

* `qx` starts recording a macro in the `x` register.
* `q` stops recording a macro
* `@x` executes the macro in register `x`

## recursive macro

* `qqq` to clear the q register
* `qq...@qq` record your macro and execute the q macro inside the recording. This won't do anything yet because we just cleared it.
* The `@q` is now recursive so it will keep executing until it hits an error

# registers

Used for pasting and for macros.

* `"ay{motion}` to yank into register a
* `"ap` to paste the text from register a

## special registers

* `""` is the default register, in most cases you don't need to specify it
* `"+` is the system clipboard, if applicable.

`:help registers` for more

# Next level

## vim commands

* `:help` contains everything there is to know about vim, in some cases it's even easier than asking google. Tip: use `<C-]>` to follow tags
* `:%s/pattern/replacement/g` If you like to do regex search and replace.
  * `%` specifies to apply it on all lines, if omitted it's only the current lines
  * `g` specifies to apply it on all occurrences, otherwise only the first is Used
  * there are more flags like `c` and `i` and others. Try to find out about them using `:help substitute`
* `:g/pattern/action` and `:v/pattern/action` are powerful as well, read on http://vim.wikia.com/wiki/Power_of_g

## 10 fingers
Vim is designed so you don't have to move your hands. If you're good a typing with 10 fingers, you will be flying.
* do not use arrow keys, do not use `del`, `home`, `end` and the like
* do not use `Esc`, but use `<C-[>` or `<C-c>`

Customizations and plugins will be covered in another page.

