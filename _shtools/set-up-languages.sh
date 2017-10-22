# search for go. I generally keep my goroot (the standard
# library and go tools live here) at ~/_go and my gopath
# (globally-installed third-party packages live here) in ~/_gopath
if [[ -d ~/_gopath && -d ~/_go ]]; then
    export GOPATH=$HOME/_gopath
    export GOROOT=$HOME/_go
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

# aliases
alias R='R --no-save'
alias py='ipython'
