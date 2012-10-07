# sets the title of your terminal window correctly
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

# set 'ls' to output in long list mode with hunam readable size units
alias ls='ls -lh'

# makes C-l (and other things which must know about the terminal type)
# always work
export TERM=xterm

# sets a minmal, useful prompt
export PS1="\u@\h \w$ "

