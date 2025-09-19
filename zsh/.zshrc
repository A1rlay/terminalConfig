##### ── Zsh minimal + Starship (one-line) ─────────────────────────

# Historial y calidad de vida
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS HIST_FIND_NO_DUPS SHARE_HISTORY
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt NO_BEEP

# Autocompletado
autoload -Uz compinit && compinit -u
zmodload zsh/complist
WORDCHARS=${WORDCHARS//\/}

# Plugins sueltos (si los tienes)
# zsh-autosuggestions
[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && \
  source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" && \
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# zsh-syntax-highlighting (siempre después de compinit)
[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] && \
  source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Aliases
alias ll='eza -lah --git --icons=auto --group-directories-first 2>/dev/null || ls -lah'
alias lt='eza -T --git-ignore --icons=auto -L 2 2>/dev/null || tree -L 2'
alias cat='batcat --paging=never 2>/dev/null || cat'

# Integraciones (si existen)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v direnv  >/dev/null 2>&1 && eval "$(direnv hook zsh)"

# === Starship al final, y solo si está disponible ===
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source "$ZSH/oh-my-zsh.sh"
alias ll="eza -lah --git --group-directories-first"
alias lt="eza -T --git-ignore -L 2"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
