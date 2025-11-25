source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Source environment variables from .env file if it exists
if [[ -f "$HOME/.env" ]]; then
  source "$HOME/.env"
fi

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward


[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias ..="cd .."
alias mkcd='function _mkcd(){ mkdir -p "$1" && cd "$1" }; _mkcd'

# ---- ssh ----
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# ---- Nvim ----
export EDITOR=nvim

# ---- Tmux ----
bindkey -s ^f "tmux-sessionizer\n"

# ---- Go ----
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# ---- Scripts ----
export PATH=$PATH:$HOME/.local/scripts
export PATH=$PATH:$HOME/.local/bin

# ---- Eza (better ls) -----
alias ll="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all --group-directories-first"

# ---- Zoxide (better cd) ----
# eval "$(zoxide init zsh)"
# alias cd="z"

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
alias ff='nvim $(fzf --preview="bat --color=always {}")'

# ---- GIT -----
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

alias glog='git log --oneline'
alias gp='git push'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpt='git push && git push --tags'
alias ga='git add --all'
alias gs='git status'
alias gc='git commit -m'
alias gcd='git checkout develop'
alias gcm='git checkout main'
alias gl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gb='git branch | fzf | xargs git checkout'

# ---- More Aliases ----
alias c='clear'
alias n='nvim .'
alias lg='lazygit'

# ---- Overflow ----
alias yd_server='yarn dev --filter=@getoverflow/server --ui=tui'
alias yd_dash='yarn dev --filter=@getoverflow/server --filter=@getoverflow/nonprofit-dashboard --ui=tui'
alias yd_flow='yarn dev --filter=@getoverflow/server --filter=@getoverflow/donor-flows --ui=tui'
alias yd_profile='yarn dev --filter=@getoverflow/server --filter=@getoverflow/donor-profile --ui=tui'
alias yd_mc='yarn dev --filter=@getoverflow/server --filter=@getoverflow/mission-control --ui=tui'

# Function to kill node server on a specific port or report if none found
kill_node_on_port() {
  local port="$1"
  local pid=$(lsof -i :"$port" | grep -Eo "node\s+([0-9]+)\s+" | grep -o "[0-9]\+")

  if [ -n "$pid" ]; then
    echo "Killing node process with PID: $pid on port $port"
    kill -9 "$pid"
  else
    echo "Nothing running on port $port"
  fi
}

# Alias to call the function with port 3232
alias ks='kill_node_on_port 3232'

# ---- Starship (shell prompt) ----
eval "$(starship init zsh)"

bindkey "\ef" forward-word
bindkey "\eb" backward-word

# ---- Terraform ----
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
