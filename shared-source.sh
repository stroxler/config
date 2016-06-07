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
alias gl='git log --abre-vocmmit --pretty=oneline -n 15'
alias gr='git rebase origin/master'

# ls aliases
alias ll='ls -lh'
alias la='ls -lah'
alias py='ipython'

# cd aliases
alias c.='cd ..'
alias c..='cd ../..'
alias c...='cd ../../..'
