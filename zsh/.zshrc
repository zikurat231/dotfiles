# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------

unsetopt BEEP


# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------

export PATH="$(go env GOPATH)/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="amuse"

# Uncomment to enable case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment to enable hyphen-insensitive completion.
# Case-sensitive completion must be disabled; underscores and hyphens will be
# treated as interchangeable.
# HYPHEN_INSENSITIVE="true"

# Configure Oh My Zsh update behavior.
# zstyle ':omz:update' mode disabled  # Disable automatic updates.
# zstyle ':omz:update' mode auto      # Update automatically without asking.
# zstyle ':omz:update' mode reminder  # Remind when an update is available.
# zstyle ':omz:update' frequency 13   # Check for updates every 13 days.

# Uncomment if pasting URLs or other text behaves incorrectly.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment to disable colors in `ls`.
# DISABLE_LS_COLORS="true"

# Uncomment to disable automatic terminal titles.
# DISABLE_AUTO_TITLE="true"

# Uncomment to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Show a custom indicator while waiting for completion.
# This may cause issues with multiline prompts in Zsh versions earlier than
# 5.7.1. The value can also be a custom string such as:
# COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# COMPLETION_WAITING_DOTS="true"

# Ignore untracked files when determining whether a repository is dirty.
# This can significantly speed up status checks in large repositories.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Configure timestamps displayed by the `history` command.
# Supported presets: "mm/dd/yyyy", "dd.mm.yyyy", and "yyyy-mm-dd".
# A custom `strftime` format may also be used.
# HIST_STAMPS="mm/dd/yyyy"

# Override the default Oh My Zsh custom directory.
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
    git
    fzf-tab
)

source "$ZSH/oh-my-zsh.sh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Initialize zoxide after Oh My Zsh so shell completion is available.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi


# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------

# export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8
# export ARCHFLAGS="-arch $(uname -m)"

export EDITOR="nvim"


# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias ll="ls -lah"
alias l="eza --color=always --long --git --icons=always --no-user --no-permissions --group-directories-first --sort=size"
alias cd="z"
alias gs="git status"
alias cl="clear"
alias t="eza --tree"
alias nv="nvim"
alias lz="lazygit"
alias cat="bat"

if [[ -f "$HOME/.local/share/omarchy/default/bash/aliases" ]]; then
  source "$HOME/.local/share/omarchy/default/bash/aliases"
fi


# -----------------------------------------------------------------------------
# Keybindings
# -----------------------------------------------------------------------------

# Enable Vim keybindings.
bindkey -v


# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

# Store command start times and durations.
setopt EXTENDED_HISTORY

# Share history between terminal and tmux sessions.
setopt SHARE_HISTORY

# Remove duplicate entries first when the history file exceeds its limit.
setopt HIST_EXPIRE_DUPS_FIRST

# Do not retain duplicate commands.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Do not display duplicate results during history searches.
setopt HIST_FIND_NO_DUPS

# Remove unnecessary whitespace from history entries.
setopt HIST_REDUCE_BLANKS

# Do not save commands that begin with a space.
setopt HIST_IGNORE_SPACE


# -----------------------------------------------------------------------------
# fzf
# -----------------------------------------------------------------------------

export FZF_DEFAULT_OPTS='
  --height=60%
  --layout=reverse
  --border
  --info=inline
  --prompt="❯ "
  --pointer="▶"
  --marker="✓"
'

export FZF_CTRL_R_OPTS='
  --prompt="history ❯ "
  --header="Enter: insert command | Ctrl-R: toggle sorting"
'

# Keep directory search fast and useful, especially when started from $HOME.
# fd does not include hidden paths unless --hidden is explicitly enabled.
export FZF_ALT_C_COMMAND='fd --type d --color=never --exclude Library --exclude node_modules --exclude .git --exclude cache --exclude caches'

# Load fzf after the other plugins so they cannot overwrite Ctrl-R.
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi


# -----------------------------------------------------------------------------
# Yazi
# -----------------------------------------------------------------------------

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
