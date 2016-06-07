# source my bash config
source "${HOME}/bash-source.sh"

# source shared config (most aliases and such go here, since
# I want them in both bash and in zsh)
source "${HOME}/shared-source.sh"

# source machine-local config, which isn't version controlled
if [[ -s "${HOME}/.local/env.sh" ]]; then
  source "${HOME}/.local/env.sh"
fi
