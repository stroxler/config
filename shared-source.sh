# shared source for bash and zsh; mostly, aliases

# make sure ghar and ~/bin are in the path
export PATH=$PATH:$HOME/ghar/bin/
export PATH=$HOME/bin:$PATH

# cd to ghar/config and .zpresto (my config repos)
alias cdpr='cd ~/.zprezto'
alias cdgc='cd ~/ghar/config'

# git aliases
alias g='git'
alias gs='git status -s'
alias gd='git diff'
alias gl='git log --abbrev-commit --pretty=oneline -n 15'
alias gr='git rebase origin/master'
alias gco='git commit'
alias gch='git checkout'

# ls aliases
alias ll='ls -lh'
alias la='ls -lah'
alias py='ipython'

# cd functions and aliases
function c() {
  set -e
  target=$1
  cd $target
  cd $(dirname $(fzf))
}
alias cgc='cd ~/ghar/config'
alias c.='cd ..'
alias c..='cd ../..'
alias c...='cd ../../..'
alias ck='cd /kode'
# this is really ergonomic
export FZF_COMPLETION_TRIGGER='`'

# vim + fzf
function vf() {
  if [ "$#" -ne 1 ]; then
    vim $(fzf)
  else
    cd $1
    vim $(fzf)
  fi
}
function vkf() {
  vf /kode
}

# emacs stuff
function emg() {
  pushd /kode
  nohup emacs 2>&1 > /dev/null &  # gui emacs server
  popd
}


alias em='emacsclient'  # command-line util for opening with emacs

# emacs + tmux stuff
alias emtn='tmux new-session -s emacs'
alias emta='tmux a -t emacs'

# history with no line numbers
function hist() {
  # note: osx sed doesn't support \+, which apparently isn't part
  # of the minimal posix standard. Hence the \{1,\}, for "1 or more"
  history | sed -e 's/^[ ]*[0-9]\{1,\}[ ]*//'
}
# fuzzy history command finder
function fh() {
  hist | fzf
}
# fuzzy history command runner
function fhr() {
  command=$(fh)
  $command
}

# alias R to exit silently
alias R='R --no-save'


# source machine-specific stuff
#   (this gets done twice in my current zsh setup, but that's ok)
if [[ -s "${HOME}.local/env.sh" ]]; then
  source "${HOME}/.local/env.sh"
fi

# set up aliases to edit this file and the local env.sh
alias vle='vim ~/.local/env.sh'
alias vss='vim ~/shared-source.sh'

# get the shell. It's a little annoying because login shells
# have a - prepended, so I strip that off.
my_shell=$(echo $0)
if [[ "${my_shell:0:1}" == "-" ]]; then
  my_shell=${my_shell:1:10}  # the 10 is just "big enough"
fi

# shell-specific stuff:
#  - loading fzf integrations
#  - setting an alias to re-source (after config edits,
#    which could be in this file, in the .zshrc/.bashrc,
#    or in `.local/env.sh`
if [[ "$my_shell" == "bash" ]]; then
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  alias sxrc='source ~/.bashrc'
else
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  alias sxrc='source ~/.zshrc'
fi

# zsh completes aliases by default, but this *needs* to go at the
# very end for bash
if [[ "$my_shell" == "bash" ]]; then
  source ~/alias_completions.sh
fi