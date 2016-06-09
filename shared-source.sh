# shared source for bash and zsh; mostly, aliases

# make sure ghar is on the path
export PATH=$PATH:$HOME/ghar/bin/

# cd to ghar/config and .zpresto (my config repos)
alias cdpr='cd ~/.zprezto'
alias cdgc='cd ~/ghar/config'

# git aliases
alias g='git'
alias gs='git status -s'
alias gd='git diff'
alias gl='git log --abbrev-commit --pretty=oneline -n 15'
alias gr='git rebase origin/master'

# ls aliases
alias ll='ls -lh'
alias la='ls -lah'
alias py='ipython'

# cd aliases
alias c.='cd ..'
alias c..='cd ../..'
alias c...='cd ../../..'

# emacs stuff
alias emg='nohup emacs 2>&1 > /dev/null &'  # gui emacs server
alias em='emacsclient --tty'  # start in-terminal emacs client
alias emc='emacsclient'  # start gui emacs client

# emacs + tmux stuff
alias emtn='tmux new-session -s emacs'
alias emta='tmux a -t emacs'


if [[ -s "${HOME}.local/env.sh" ]]; then
  source "${HOME}/.local/env.sh"
fi
