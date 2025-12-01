# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="clean" # set by `omz`

# Path
export PATH=$HOME/.local/bin:/opt/homebrew/bin:$HOME/.scripts:$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH="$HOME/.rbenv/bin:$HOME/go/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export AWS_VAULT_KEYCHAIN_NAME=login
# source <(kubectl completion zsh)

# ZSH Plugins
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
plugins=(z git docker docker-compose aws kubectl tmux terraform zsh-autosuggestions)
ZSH_THEME="powerlevel10k/powerlevel10k"

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
alias 2aws='2fa aws | tr -d '\n' | pbcopy'
alias tg=terragrunt
alias myip='curl ifconfig.me'
alias cdg='cd $(git rev-parse --show-toplevel)'
alias branch='git rev-parse --abbrev-ref HEAD | pbcopy'
alias gdash='GITHUB_TOKEN=$GITHUB_TOKEN gh dash'
alias rewifi='sudo ifconfig en0 down && sudo ifconfig en0 up'

# Smile Aliases
alias smile=/Users/milad/.rbenv/shims/smile-cli
alias smileprod='smile aws login --env=prod'
alias smiledev='smile aws login --env=dev'
alias smilestage='smile aws login --env=stage'
alias smilesandbox='smile aws login --env=sandbox-1'
alias k9stage=' smile vpn dis && smile vpn connect --env stage && smile exec -e stage -- k9s'
alias k9prod=' smile vpn dis && smile vpn connect --env prod && smile exec -e prod -- k9s'
alias k9dev=' smile vpn dis && smile vpn connect --env dev && smile exec -e dev -- k9s'
alias k9sandbox=' smile vpn dis && smile vpn connect --env sandbox-1 && smile exec -e sandbox-1 -- k9s'
alias k9shared='smile vpn dis && smile vpn connect --env shared-services && smile exec -e shared-services -- k9s'
alias vpndev='smile vpn dis && smile vpn connect --env dev'
alias vpnprod='smile vpn dis && smile vpn connect --env prod'
alias vpnstage='smile vpn dis && smile vpn connect --env stage'
alias vpnsandbox='smile vpn dis && smile vpn connect --env sandbox-1'


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
eval "$(atuin init zsh --disable-up-arrow)"

# pnpm
export PNPM_HOME="/Users/milad/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Load all functions from the ~/.scripts directory
if [ -d ~/.scripts ]; then
    for file in ~/.scripts/*.sh; do
        [ -r "$file" ] && source "$file"
    done
fi

# Default Editor
export VISUAL=nvim
export EDITOR=nvim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/milad/.local/share/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/milad/.local/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/milad/.local/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/milad/.local/share/google-cloud-sdk/completion.zsh.inc'; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terragrunt terragrunt

eval "$(rbenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/milad/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
