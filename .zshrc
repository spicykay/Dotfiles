# fpath+=("/opt/homebrew/share/zsh/site-functions")
# ZSH_DISABLE_COMPFIX=true
# autoload -U promptinit; promptinit
# zstyle :prompt:pure:path color blue
# zstyle :prompt:pure:git:dirty color yellow
# zstyle :prompt:pure:git:branch color magenta
# prompt pure

eval "$(starship init zsh)"

# Default Setup Variables
DEFAULT_USER="KartikAyalasomayajula"
DEV_DIR_PATH="/Users/${DEFAULT_USER}/dev"

########## OH MY ZSH SETUP ##########
export ZSH="/Users/${DEFAULT_USER}/.oh-my-zsh"

# Disable ZSH Substitution and autocompletion with URL
DISABLE_MAGIC_FUNCTIONS=true

plugins=(
  wd
  fzf
  autojump
  zsh-autosuggestions
  zsh_reload
  zsh-completions
  golang
  git
  mvn
  docker
  gem
  rbenv
  ruby
  history-substring-search
  zsh-syntax-highlighting
)

autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='vim'
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"
# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

########## GOLANG ##########
export GOPATH=$HOME/go

########## MAVEN ##########
alias mi='mvn install'
alias mci='mvn clean install'
alias mcit='mvn clean install -DskipTests=true'
alias mcif='mvn clean install -T2C -DskipTests=true -Dmaven.test.skip=true -Dcheckstyle.skip=true -Dmdep.analyze.skip=true -DskipRedis=true'

########### GIT ##########
# Custom Git Aliases
alias gcm="git checkout master || git checkout main"
alias grs="git pull --rebase source master"
alias grm="git pull --rebase origin master"
alias branch="git branch -a | grep -oE '[^ ]+$' | fzf --preview='git show --color=always --stat {}'"
alias guf='git pull --rebase source master && git push origin master'

########### KUBERNETES ##########
alias k="kubectl"
alias kpo="kubectl get pods"
source <(kubectl completion zsh)

########### PATH DEFINITIONS ##########
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/libressl/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/curl-openssl/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=/usr/local/anaconda3/bin:"$PATH"

########## GRAPHWIZ ##########
export GRAPHVIZ_DOT=/usr/local/Cellar/graphviz/2.40.1_1/bin/dot

########## Fuzzy Finder ##########
export FZF_BASE=$(which fzf)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

########## ITERM ##########
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

########## PYTHON ##########
# Python System Environment Variables
export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
export CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib"
export CPPFLAGS="-I$(brew --prefix zlib)/include"
eval "$(pyenv init -)"

########## DOCKER ##########
export DOCKER_DEFAULT_PLATFORM="linux/amd64"

########## RUBY ##########
# Ruby m1 mac compatibility flags
# https://github.com/asdf-vm/asdf-ruby/issues/198
export RUBY_CONFIGURE_OPTS="--with-zlib-dir=/opt/homebrew/opt/zlib --with-openssl-dir=/opt/homebrew/opt/openssl@1.1 --with-readline-dir=/opt/homebrew/opt/readline --with-libyaml-dir=/opt/homebrew/opt/libyaml"
export RUBY_CFLAGS="-Wno-error=implicit-function-declaration"

########## Man Pages ##########
alias man='/usr/bin/man 2>/dev/null'

########## FSHOW ##########
# fshow - git commit browser (enter for show, ctrl-d for diff, ` toggles sort)
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

########## ASDF ##########
. $(brew --prefix asdf)/libexec/asdf.sh
export PATH="$PATH:$(asdf where nodejs)/.npm/bin"
. ~/.asdf/plugins/java/set-java-home.zsh

########## Terraform ##########
export TFENV_ARCH=amd64

########## Application Aliases ##########
alias lx='exa'

# DIRENV Integration: https://github.com/asdf-community/asdf-direnv
eval "$(direnv hook zsh)"

########## BROOT ##########
# https://github.com/Canop/broot
source "/Users/${DEFAULT_USER}/.config/broot/launcher/bash/br"
