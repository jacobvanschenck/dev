# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# ---- Nvim ----
export EDITOR=nvim

# ---- Tmux ----
bindkey -s ^f "tmux-sessionizer\n"

# ---- Go ----
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# ---- Scripts ----
export PATH=$PATH:$HOME/.local/scripts

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
