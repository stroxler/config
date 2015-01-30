# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# prepend to path for homebrew python to supercede system python on mac
export PATH=/usr/local/bin:$PATH

# history
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='aa:co:ps:pl'
export HISTSIZE=10000
export HISTFILESIZE=10000
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# this will need modification per computer
export PYTHONPATH=$PYTHONPATH:$HOME/kp:$HOME/cc/pathdir

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# git aliases
alias st='git status -s'
alias ad='git add' #; __git_complete ad _git_add
alias aa='git add .'
alias co='git commit'
alias ch='git checkout' #; __git_complete ch _git_checkout
alias lo='git log'
alias cl='git clone'
alias di='git diff'
alias pu='git push origin master'
alias pl='git pull'
alias br='git branch'

# place aliases
alias de='cd /devel'
alias da='cd /data'
alias dp='cd /usr/local/lib/python2.7/dist-packages'
alias gh='cd ~/ghar/config'

# cd
alias c='cd'
alias c.='cd ..'
alias c..='cd ../..'
alias c...='cd ../../..'
alias p='cd \-'
alias n='nautilus .'

# ls aiases
alias l='ls --ignore="*.pyc"'
alias ll='ls -lh'
alias la='ls -lah'

# make aliases
alias ma='make all'
alias mt='make test'
alias mf='make test_full'
alias m8='make flake8'

# misc aliases
alias py='ipython'
alias me='meld .'
alias sb='source ~/.bashrc'
alias v='vim -c "cd /devel"'

if hash brew 2>/dev/null; then
    # I'm on a mac, load up the brew git completion and prompt stuff
    if [ -f `brew --prefix`/etc/bash_prompt ]; then
        . `brew --prefix`/etc/bash_prompt
    fi
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
    # Also, use macvim as my terminal vim
    # why? mostly because "+ doesn't refer to the clipboard in system vim,
    # but it does in macvim. (Of course if you are sshing into a terminal
    # it won't matter)
    #vim()
    #{
    #    command mvim -v "$@"
    #}

else
    # I'm probably on Ubuntu, which packages git completion with git
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
    # or I'm on some other linux, in which case I should wget a copy
    # of .bash_git, eg
    # wget https://raw.githubusercontent.com/aequasi/dotfiles/master/.bash_git
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
fi

# Fancy promt
PS1='\[\033[0;34m\]${debian_chroot:+($debian_chroot)}\u@\h\[\033[33m\]:\w`__git_ps1`\$\[\033[00m\] '
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

export PATH=$PATH:$HOME/ghar/bin/

# I don't use c-s any more; switched to c-w. This doesn't work on mac,
# but does on ubuntu.
# When vim is used in terminal (instead of gui) the terminal should pass
# through CNTRL-S to vim (for use as 'save') instead of stop scrolling
#vim()
#{
#    local STTYOPTS="$(stty --save)"
#    stty stop '' -ixoff
#    command vim "$@"
#    stty "$STTYOPTS"
#}

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
