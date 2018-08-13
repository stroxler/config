if [[ -d ~/_gopath ]]; then
    export GOROOT=/usr/local/go  # NOTE: this is probably not portable to linux; this is the brew goroot
    export GOPATH=$HOME/_gopath
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# if I'm on OSX, this command will find JAVA_HOME for me
# on linux, /usr/libexec/java_home does not exist
if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=$PATH:$JAVA_HOME/bin
fi


# pyenv support
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# nvm support
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rvm support
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# aliases
alias R='R --no-save'
alias py='ipython'
