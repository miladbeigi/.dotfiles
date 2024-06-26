
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path
export PATH=$HOME/.local/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ZSH Plugins
plugins=(z zsh-syntax-highlighting git docker docker-compose aws kubectl zsh-autosuggestions tmux terraform)

source $ZSH/oh-my-zsh.sh

# FZF Options
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --theme=gruvbox-dark --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
--bind 'shift-up:preview-page-up,shift-down:preview-page-down'
"

# Aliases
alias zvim='vim $(fzf)'
alias k=kubectl
alias vim=nvim
alias c=clear
alias gcof='git checkout $(git branch -a | fzf)'
alias cos='gh copilot suggest -t shell $1'
alias coe='gh copilot explain $1'
alias lg='lazygit'
alias h='atuin search --interactive --search-mode fuzzy'

# ZSH Bindings
bindkey \^U backward-kill-line

# Pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Terraform Bash Completion
complete -o nospace -C /usr/local/bin/terraform terraform

# NVM 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Shell history plugin
eval "$(atuin init zsh)"

# pnpm
export PNPM_HOME="/Users/milad/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Default Editor
export VISUAL=nvim
export EDITOR=nvim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
