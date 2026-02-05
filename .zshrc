# ZSH configuration file.
#
# Requires the powerline-go shell theme (use powerlevel9k as fallback)
# For installation instructions, see https://github.com/justjanne/powerline-go
#
# Basically:
#   <install golang>
#   go install github.com/justjanne/powerline-go@latest
#
# Powerlevel9k is used as a fallback if powerline-go is not found.
#
# The theme also requires antigen, which is embedded as a Git submodule
# in this repository. Clone it via:
#
#   git submodule update --init --recursive

# Define internal paths
if [ -z "$GOPATH" ]; then
    export GOPATH="${HOME}/go"
fi
ANTIGEN_PATH="${HOME}/dotfiles/antigen"
POWERLINE_PATH="${GOPATH}/bin/powerline-go"

# Set up powerline-go
powerline_precmd() {
    eval "$(${POWERLINE_PATH} -error $? -shell zsh -eval \
        -modules 'nix-shell,ssh,venv,user,host,cwd,perms' \
        -modules-right 'exit,jobs,git,docker,kube' \
        -priority 'root,venv,ssh,exit,cwd,user,perms,host,jobs,git-branch,git-status,cwd-path' \
        -cwd-max-depth 2 -max-width 30 -truncate-segment-width 25)"
}

install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

SHELL_THEME="powerlevel9k"
if [ -x "$POWERLINE_PATH" ]; then
    SHELL_THEME="powerline"
fi
 
# Powerlevel9k configuration
if [[ "$SHELL_THEME" == "powerlevel9k" ]]; then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir background_jobs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs)
    POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
fi

# Source custom environment variables (PATH etc.)
if [ -f "${HOME}/.env" ]; then
    source "${HOME}/.env"
fi

# Explicitly set LC_* locale to prevent tab completion issues for remote connections
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}

# Load Antigen package manager
source "${ANTIGEN_PATH}/antigen.zsh"

antigen use oh-my-zsh

# Oh-my-zsh default plugins
antigen bundle colored-man-pages
antigen bundle encode64
antigen bundle git-extras
antigen bundle github
antigen bundle history
antigen bundle jsontools
antigen bundle pip
antigen bundle python
antigen bundle screen
antigen bundle sudo
antigen bundle systemd
antigen bundle wd

# Third-party plugins
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

# Other ZSH extensions
autoload -U zmv

# Powerlevel9k fallback theme
if [[ "$SHELL_THEME" == "powerlevel9k" ]]; then
    antigen theme bhilburn/powerlevel9k powerlevel9k
fi

# Apply plugins and themes
antigen apply 2>&1 > /dev/null

# Powerline shell theme
if [[ "$SHELL_THEME" == "powerline" ]]; then
    install_powerline_precmd
fi

# Proper umask (needed for WSL and maybe some other broken systems)
umask 022

# Tree-view for kill command completion
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'

# Use zoxide instead of cd if installed
if command -v zoxide > /dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# Manage SSH keys with keychain if installed
if $(command -v keychain > /dev/null); then
    keychain id_ed25519
    source  ~/.keychain/$(hostname)-sh
fi

# On WSL, connect to OpenSSH agent on Windows
# Requires socat to be installed in WSL and npiprelay on the Windows side.
# The latter can be downloaded from https://github.com/jstarks/npiperelay
# Set NPIPRELAY_PATH to the path of the executable (e.g. in ~/.env)
# If using the Windows OpenSSH agent, you should uninstall keychain.
if [[ "$(uname -r)" == *microsoft-standard* ]] && [ -n "$NPIPRELAY_PATH" ]; then
    export SSH_AUTH_SOCK="${HOME}/.ssh/agent.sock"
    ss -a | grep -q "$SSH_AUTH_SOCK"
    if [ $? -ne 0   ]; then
        rm -f "$SSH_AUTH_SOCK"
        (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"${NPIPRELAY_PATH} -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
    fi
fi

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

