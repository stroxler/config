#!/usr/bin/env bash

# Installing use-package out-of-band is needed for my current virtual
# emacs setup to work (the underlying issue is that spacemacs was having
# trouble bootstrapping it, so I hacked it into ~/.emacs.el)

if [[ ! -d ~/_extra_emacs_packages/use-package ]]; then
  mkdir ~/_extra_emacs_packages
  cd ~/_extra_emacs_packages
  git clone https://github.com/jwiegley/use-package
fi
