# general aliases
alias tl='tmux ls'
alias tk='ttmux-kill'
alias tn='ttmux-new-session'
alias ta='ttmux-attach-to-session'

# task-specific aliases
alias tpy='ttmux-new-ipython-session'

# notes on tmux stuff I learned that doesn't show up here --------------------

# with tmux new-session and tmux-new-window...
#  - tmux new is equivalent to tmux new-session
#  - the -t flag is used for the session, -n for the window name
#    (window name will be auto-set by incrementing a counter if not given)
#  - the -d flag will cause tmux to detach from the session
#  - you can also give a -c flag to change directory
#  - there is an optional command, which is a regular positional arg

# it's not clear that this is a good idea, but in order to at least
# temporarily use tmux for *all* iterm sessions while also enabling my
# tmux for ipython shortcut, I'm allowing nexted tmux sessions
#
# I should turn this off if either of the following happen:
#   - I decide not to enable tmux for all terminals
#   - I wind up only using iterm2 integration to spin up tmux, but not
#     app-specific stuff like tpy... in this case, my tmux-targeting
#     logic (probably vim and emacs tools) should just use the "it" sessions
#     for everything, and there won't be any need for nested sessions
export TMUX=""

# ttmux general functions ----------------------------------------------------

ttmux-find-last-session() {
  prefix=$(-ttmux-get-prefix $1)
  last_session=$(
    tmux ls | \
      awk 'BEGIN { FS = ":" } ; { print $1 }' | \
      grep "^$prefix" | \
      sort | tail -n 1
  ) 
  echo $last_session
}

ttmux-new-session() {
  session_name=$(-ttmux-next-session-name $1)
  tmux new -s $session_name
}

ttmux-kill() {
  if [ -z $1 ]; then echo 'Usage: ttmux-kill SESSION' >&2; fi
  session=$1
  tmux kill-session -t $session
}


ttmux-attach-to-session() {
  if [ -z $1 ]; then echo 'Usage: ttmux-attach-to-session SESSION' >&2; fi
  session=$1
  tmux a -t $session
}

# task-specific functions

ttmux-new-session-with-command() {
  if [ -z $1 ]; then
    echo 'Usage: ttmux-new-session-with-command PREFIX CMD' >&2
  fi
  prefix=$1
  cmd=$2
  session_name=$(-ttmux-next-session-name $prefix)
  tmux new -s $session_name $cmd
}

ttmux-new-ipython-session() {
  ttmux-new-session-with-command py ipython
}

# ttmux utility functions -----------------------------------------------------

-ttmux-get-prefix() {
  if [ -z $1 ]; then prefix='default'
  else prefix=$1; fi
  echo $prefix
}

-ttmux-mk-session-name() {
  if [ -z $1 ]; then
    echo "Usage: -ttmux-get-session PREFIX NUMBER" >&2
  fi
  if [ -z $2 ]; then
    echo "Usage: -ttmux-get-session PREFIX NUMBER" >&2
  fi
  echo "$1--$2"
}

-ttmux-number-from-session-name() {
  if [ -z $1 ]; then 
    echo "Usage: -ttmux-number-from-session SESSION_NAME" >&2
  fi
  session=$1
  echo ${session##*--}
}

-ttmux-next-session-number() {
  last_session=$(ttmux-find-last-session $1)
  if [ -z $last_session ]; then
    next_session_number=0
  else
    last_session_number=$(-ttmux-number-from-session-name $last_session)
    next_session_number=$((last_session_number + 1))
  fi
  echo $next_session_number
}

-ttmux-next-session-name() {
  prefix=$(-ttmux-get-prefix $1)
  next_session_number=$(-ttmux-next-session-number $prefix)
  next_session_name=$(-ttmux-mk-session-name $prefix $next_session_number)
  echo $next_session_name
}
