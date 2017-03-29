
# set up aliases to edit this file and the local env.sh
alias vle='vim ~/.local/env.sh'
alias vss='vim ~/shared-source.sh'

# git aliases
alias ga='git add'
alias gs='git status -s'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --oneline --decorate -n 15'
alias gre='git rebase'
alias grom='git rebase origin/master'
alias gco='git commit'
alias gcoa='git commit --amend'
alias gch='git checkout'
alias gcb='git checkout -b'
alias gpu='git push'
alias gbr='git branch'
alias gre='git rebase'
alias gfe='git fetch'

# curl with json headers
alias jcurl='curl -H "Content-Type: application/json"'

# ls aliases
alias ll='ls -lhG'
alias ls='ls -G'
alias la='ls -lah'

# cd functions and aliases
function c() {
  set -e
  target=$1
  cd $target
  cd $(dirname $(fzf))
}
# cd to ghar/config and .zpresto (my config repos)
alias c='cd'
alias cem='cd ~/.emacs'
alias cgc='cd ~/ghar/config'
alias cb='cd ~/Dropbox'
alias c.='cd ..'
alias c..='cd ../..'
alias c...='cd ../../..'
alias ck='cd /kode'



ckk () {
  cd /kode
  cd $( find . -type d | fzf )
}
