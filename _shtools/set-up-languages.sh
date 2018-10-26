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
  if [ -d  "$HOME"/.pyenv/plugins/pyenv-virtualenv ]; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# nvm support
export NVM_DIR="$HOME/.nvm"
  export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# cargo (rust) support
[[ -s "$HOME/.cargo/env" ]] && \. "$HOME/.cargo/env" 
if which rustc > /dev/null; then
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# rvm support
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if command -v opam 1>/dev/null; then
  eval $(opam env)
fi

# aliases
alias R='R --no-save'
alias py='ipython'
