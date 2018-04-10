#!/usr/bin/env bash

# Bash script for cloning all of my vim plugins

set -e
PREFIX='git@github.com:'
PATHOGEN_DIR="$HOME/basic-vim/$this_dir/bundle"

Plugin() {
    owner=$1
    repository=$2
    if [[ -z $owner ]]; then
        echo "Usage: Plugin <owner> <repository>"
        return 1
    fi
    if [[ -z $repository ]]; then
        echo "Usage: Plugin <owner> <repository>"
        return 1
    fi
    if [[ -d $repository ]]; then
        echo "Updating ${owner}/${repository}"
        pushd $repository
            git fetch
            git rebase origin/master
        popd
    else
        echo "Cloning ${owner}/${repository}"
        git clone "${PREFIX}${owner}/${repository}.git"
    fi
}


mkdir -p ${PATHOGEN_DIR}

pushd ${PATHOGEN_DIR}

    # spacevim dependencies
    Plugin 'airblade' 'vim-gitgutter'
    Plugin 'dbakker' 'vim-projectroot'
    Plugin 'easymotion' 'vim-easymotion'
    Plugin 'junegunn' 'fzf'
    Plugin 'junegunn' 'fzf.vim'
    Plugin 'junegunn' 'gv.vim'
    Plugin 'mbbill' 'undotree'
    Plugin 'scrooloose' 'syntastic'
    Plugin 'tpope' 'vim-commentary'
    Plugin 'tpope' 'vim-eunuch'
    Plugin 'tpope' 'vim-fugitive'

    # mis-specified as optional
    Plugin 'hecal3' 'vim-leader-guide'

    # spacevim
    Plugin 'ctjhoa' 'spacevim'

    # spacevim
    Plugin 'haya14busa' 'incsearch.vim'

    # spacevim recommended plugins
    #   (note: I removed delimitMate)
    Plugin 'osyo-manga' 'vim-over'
    Plugin 'tpope' 'vim-surround'

    # langages
    Plugin 'tpope' 'vim-markdown'
    Plugin 'derekwyatt' 'vim-scala'
    Plugin 'ensime' 'ensime-vim'
    Plugin 'digitaltoad' 'vim-jade'
    Plugin 'fatih' 'vim-go'
    Plugin 'tpope' 'vim-fireplace'
    Plugin 'hynek' 'vim-python-pep8-indent'
    Plugin 'kchmck' 'vim-coffee-script'
    Plugin 'tpope' 'vim-speeddating'
    Plugin 'jceb' 'vim-orgmode'
    Plugin 'Shougo' 'neocomplete.vim'
    Plugin 'Shougo' 'vimproc.vim'
    Plugin 'eagletmt' 'ghcmod-vim'
    Plugin 'eagletmt' 'neco-ghc'

    # bonus stuff
    Plugin 'ervandew' 'supertab'
    Plugin 'vim-scripts' 'bufkill.vim'

    # ctl-p ... I've found that spacemacs FZF defaults aren't good enough
    # for some purposes
    Plugin 'ctrlpvim' 'ctrlp.vim'

    # nondestructive themes
    Plugin 'lifepillar' 'vim-solarized8'
    Plugin 'romainl' 'Apprentice'
    # destructuve (but nice) themes
    Plugin 'liuchengxu' 'space-vim-dark'
    Plugin 'morhetz' 'gruvbox'

popd
