# options

setopt histignorealldups sharehistory prompt_subst ignoreeof auto_cd auto_pushd pushd_ignore_dups no_flow_control
bindkey -e

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# env
export EDITOR="vim"
export PAGER="less"

# Set up the prompt

autoload -Uz promptinit && promptinit
autoload -Uz colors && colors
autoload -Uz add-zsh-hook vcs_info

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats " %c%u%b"
zstyle ':vcs_info:*' actionformats ' %c%u%b[%a]'

# Keep lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE="10000"
SAVEHIST="10000"
HISTFILE="$HOME/.zsh_history"

# syntax-highliting
if [[ -f "$HOME/.dotfiles-macbook/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]
then
  source "$HOME/.dotfiles-macbook/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

  # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/highlighters/main/main-highlighter.zsh
  ZSH_HIGHLIGHT_STYLES[arg0]="fg=blue"
  ZSH_HIGHLIGHT_STYLES[precommand]="fg=012,underline"
  ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=012,underline"
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=012"
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=012"
fi

# autosuggestions
if [[ -f "$HOME/.dotfiles-macbook/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]
then
  source "$HOME/.dotfiles-macbook/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# pure
prompt pure
export PURE_PROMPT_SYMBOL='$'

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
export VIRTUAL_ENV_DISABLE_PROMPT="true"

# pipenv
export PIPENV_VENV_IN_PROJECT="true"

# poetry
pyenv which poetry > /dev/null 2>&1 && (
  poetry config virtualenvs.in-project true
)

# nodenv
eval "$(nodenv init -)"

# gvm
source $HOME/.gvm/scripts/gvm

# kubectl
source <(kubectl completion zsh)

# direnv
eval "$(direnv hook zsh)"

# symlink
[[ -L "$HOME/.gitconfig" ]] || ln -s "$HOME/.dotfiles-macbook/.gitconfig" "$HOME/.gitconfig"
[[ -L "$HOME/.vimrc" ]] || ln -s "$HOME/.dotfiles-macbook/.vimrc" "$HOME/.vimrc"
[[ -L "$HOME/.gitignore" ]] || ln -s "$HOME/.dotfiles-macbook/.gitignore" "$HOME/.gitignore"

# compile
if [[ "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc" ]]
then
   zcompile "$HOME/.zshrc"
fi
