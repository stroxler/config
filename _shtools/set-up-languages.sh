
# set up virtualenvs
if [[ -s "/usr/local/bin/virtualenvwrapper.sh" ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
  export WORKON_HOME="$HOME/.virtualenvs"
fi

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

# aliases
alias R='R --no-save'
alias py='ipython'

# don't evaluate autocompletion for click, but do make an alias to do
# call a script in ~/.local. The reason to not insta-evaluate is that it's
# pretty slow
alias click-autocomp='source ~/.local/click_autocompletes.sh'

