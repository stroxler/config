# shared source for bash and zsh; mostly, aliases
# make sure ghar and ~/bin are in the path
export PATH=$PATH:$HOME/ghar/bin
export PATH=$HOME/bin:$HOME/.local/bin:$PATH



# this is really ergonomic, use `TAB to complete
export FZF_COMPLETION_TRIGGER=\`
# make FZF use ag, which respects .gitignore
export FZF_DEFAULT_COMMAND='ag -g ""'

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
  source ~/alias-completions.sh
fi


# source machine-specific stuff
#   (this gets done twice in my current zsh setup, but that's ok)
if [[ -s "${HOME}/.local/env.sh" ]]; then
  source "${HOME}/.local/env.sh"
fi

. ~/_shtools/basics.sh
. ~/_shtools/set-up-languages.sh
. ~/_shtools/ttmux.sh