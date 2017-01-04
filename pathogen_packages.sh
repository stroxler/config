#!/usr/bin/env bash

# Bash script for cloning all of my vim plugins

set -e
PREFIX='git@github.com:'
PATHOGEN_DIR="${HOME}/.vim/bundle"

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

PluginMake() {
    owner=$1
    repository=$2
    if [[ -z $owner ]]; then
        echo "Usage: Plugin <owner> <repository>"
        exit 1
    fi
    if [[ -z $repository ]]; then
        echo "Usage: Plugin <owner> <repository>"
        exit 1
    fi
    Plugin "${owner}" "${repository}"
    pushd "${repository}"
        make
    popd
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

    # bonus stuff
    Plugin 'ervandew' 'supertab'
    Plugin 'vim-scripts' 'bufkill.vim'

    # ctl-p ... I've found that spacemacs FZF defaults aren't good enough
    # for some purposes
    Plugin 'ctrlpvim' 'ctrlp.vim'

    # COLORS ------------------------------
    #
    # NOTES
    #
    # by color
    # --------
    # blueish color themes:
    #   - deepspace [in guis, not terminal]
    #   - shades-of-teal
    # grey-back color themes:
    #   - vydark
    #   - apprentice
    #   - mod8
    #   - tender
    #   - termschool
    #   - deep-space [in terminal]
    # others:
    #   - gruvbox brownish, light and dark versions
    #
    # by terminal behavior
    # --------------------
    # completely good:
    #   - gruvbox
    #   - tender
    #   - termschool
    #   - apprentice
    # pretty good but different from gui:
    #   - deep-space
    # not good:
    #   - vydark
    #   - shades-of-teal
    #   - mod8
    Plugin 'morhetz' 'gruvbox'
    Plugin 'romainl' 'Apprentice'
    Plugin 'jonathanfilip' 'vim-lucius'
    Plugin 'vyshane' 'vydark-vim-color'
    Plugin 'kristiandupont' 'shades-of-teal'
    Plugin 'tyrannicaltoucan' 'vim-deep-space'
    Plugin 'easysid' 'mod8.vim'
    Plugin 'marcopaganini' 'termschool-vim-theme'
    Plugin 'jacoborus' 'tender.vim'
    # base16-altier*, base16-ateliersulphurpool was motivation
    #   the other decent one is savanna
    Plugin 'atelierbram' 'vim-colors_atelier-schemes'
    # flattened-light and flattened-dark (tweaked solarized)

    # colurs I used to use
    # (no zenburn b/c I prefer emacs)
    # Plugin 'stroxler/Zenburn'
    # (no flattened/solarized b/c I prefer emacs)
    # Plugin 'romainl' 'flattened'

    Plugin 'Shougo' 'vimproc.vim'
    Plugin 'eagletmt' 'ghcmod-vim'
    Plugin 'eagletmt' 'neco-ghc'
popd
