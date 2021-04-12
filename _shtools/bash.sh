# ~/.bashrc: executed by bash(1) for non-login shells.

export EDITOR="vim"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# history
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='aa:co:ps:pl'
export HISTSIZE=10000
export HISTFILESIZE=10000
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(shell=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then

    # colors
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

fi

# fancy promt
source ~/.git-prompt.sh
source ~/.git-completion.sh
GIT_PS1='\[\033[0;34m\]${debian_chroot:+($debian_chroot)}\u@\h\[\033[33m\] : \w`__git_ps1`\n>\[\033[00m\] '
NOGIT_PS1='\[\033[0;34m\]${debian_chroot:+($debian_chroot)}\u@\h\[\033[33m\] : \w\n>\[\033[00m\] '
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
alias git_prompt='export PS1=$GIT_PS1'
alias nogit_prompt='export PS1=$NOGIT_PS1'
nogit_prompt

# git status all (sta) -------------------------------------------------------
#
# modified from https://coderwall.com/p/ewz5zq

function sta () {
    for gitdir in `find . -name .git`;
    do
        worktree=${gitdir%/*};
        if (! unstaged_changes $gitdir) || (! uncommited_changes $gitdir) \
           || (untracked $gitdir = 0)
        then
            echo "=== $gitdir ==="
            git --git-dir=$gitdir --work-tree="$worktree" status -s
        fi
    done
}

function unstaged_changes() {
    worktree=${1%/*};
    git --git-dir="$1" --work-tree="$worktree" diff-files --quiet \
        --ignore-submodules --
}

function uncommited_changes() {
    worktree=${1%/*};
    git --git-dir="$1" --work-tree="$worktree" diff-index --cached --quiet \
        HEAD --ignore-submodules --
}

function untracked() {
    worktree=${1%/*};
    git --git-dir="$1" --work-tree="$worktree" ls-files --other \
        --exclude-standard --error-unmatch . >/dev/null 2>&1
}
