#!/usr/bin/env bash

# Bash script for cloning all of my vim plugins

set -e
PREFIX='git@github.com:'
PATHOGEN_DIR="$HOME/basic-vim/$this_dir/bundle"

Plugin() {
    repository=$1
    if [[ -z $repository ]]; then
        echo "Usage: Plugin <repository>"
        return 1
    fi
    repo_dir="${repository#*/}"
    if [[ -d $repo_dir ]]; then
        echo "Updating ${repo_dir}"
        pushd $repo_dir
            git fetch
            git rebase origin/master
        popd
    else
        echo "Cloning ${repository}"
        git clone "${PREFIX}${repository}.git"
    fi
}


mkdir -p ${PATHOGEN_DIR}

pushd ${PATHOGEN_DIR}

    # core color themes
    Plugin 'romainl/Apprentice'
    Plugin 'arcticicestudio/nord-vim'
    Plugin 'nightsense/stellarized'
    Plugin 'kristijanhusak/vim-hybrid-material'
    Plugin 'tyrannicaltoucan/vim-deep-space'

    # library with many color themes
    Plugin 'chriskempson/base16-vim'

    # spacevim dependencies
    Plugin 'airblade/vim-gitgutter'
    Plugin 'dbakker/vim-projectroot'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'junegunn/gv.vim'
    Plugin 'mbbill/undotree'
    Plugin 'scrooloose/syntastic'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-eunuch'
    Plugin 'tpope/vim-fugitive'
    # # Commenting this out because fzf vim hasn't worked well for me
    # # recently, but I don't want to remove it entirely (fzf is awesome!)
    # Plugin 'junegunn/fzf'
    # Plugin 'junegunn/fzf.vim'

    # mis-specified as optional
    Plugin 'hecal3/vim-leader-guide'

    # spacevim
    Plugin 'ctjhoa/spacevim'

    # spacevim
    Plugin 'haya14busa/incsearch.vim'

    # spacevim recommended plugins
    #   (note: I removed delimitMate)
    Plugin 'osyo-manga/vim-over'
    Plugin 'tpope/vim-surround'

    # langages
    Plugin 'tpope/vim-markdown'
    Plugin 'derekwyatt/vim-scala'
    Plugin 'digitaltoad/vim-jade'
    ## Plugin 'ensime/ensime-vim'  # causes issues in python2 land
    Plugin 'fatih/vim-go'
    Plugin 'tpope/vim-fireplace'
    Plugin 'hynek/vim-python-pep8-indent'
    Plugin 'kchmck/vim-coffee-script'
    Plugin 'tpope/vim-speeddating'
    Plugin 'jceb/vim-orgmode'
    Plugin 'Shougo/neocomplete.vim'
    Plugin 'Shougo/vimproc.vim'
    Plugin 'eagletmt/ghcmod-vim'
    Plugin 'eagletmt/neco-ghc'

    # bonus stuff
    Plugin 'ervandew/supertab'
    Plugin 'vim-scripts/bufkill.vim'

    # ctl-p ... I've found that spacemacs FZF defaults aren't good enough
    # for some purposes
    Plugin 'ctrlpvim/ctrlp.vim'

popd
