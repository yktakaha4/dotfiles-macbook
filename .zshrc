# completion
autoload -Uz compinit
compinit

# pure
autoload -U promptinit; promptinit
prompt pure

# env
export EDITOR="vim"
export PAGER="less"

# alias
alias vzrc='vim ~/.zshrc'
alias .zrc='. ~/.zshrc'

alias ls='ls --color'
alias ll='ls -l'
alias la='ls -la'
alias l='ll'

alias less='less -R'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias .='source'

alias lgrep='grep --line-buffered'

alias tf='terraform'

alias dcu='docker-compose up -d --remove-orphans'
alias dcd='docker-compose down'
alias dcl='docker-compose logs -f --tail=10'
alias dcp='docker-compose ps'
alias dcx='docker-compose exec'
alias dcr='docker-compose restart'
function dcul() {
  dcu $@ && dcl
}

alias k='kubectl'

alias ssh="ssh -o ServerAliveInterval=60"

alias iam='aws sts get-caller-identity --query Arn --output text'

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# nodenv
eval "$(nodenv init -)"

# gvm
source $HOME/.gvm/scripts/gvm

# kubectl
source <(kubectl completion zsh)

# direnv
eval "$(direnv hook zsh)"
