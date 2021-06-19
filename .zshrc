ZSH_DISABLE_COMPFIX=true
autoload -U promptinit; promptinit
zstyle :prompt:pure:path color blue
zstyle :prompt:pure:git:dirty color yellow
zstyle :prompt:pure:git:branch color magenta
prompt pure

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
export ARCHFLAGS="-arch x86_64"
# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

########## MAVEN ##########
alias mi='mvn install'
alias mci='mvn clean install'
alias mcit='mvn clean install -DskipTests=true'
alias mcif='mvn clean install -T2C -DskipTests=true -Dmaven.test.skip=true -Dcheckstyle.skip=true -Dmdep.analyze.skip=true'

########### GIT ##########
# Custom Git Aliases
alias gcm="git checkout master || git checkout main"
alias grs="git pull --rebase source master"
alias grm="git pull --rebase origin master"
alias branch="git branch -a | grep -oE '[^ ]+$' | fzf --preview='git show --color=always --stat {}'"

########### KUBERNETES ##########
alias k="kubectl"
alias kpo="kubectl get pods"
source <(kubectl completion zsh)

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

########### PATH DEFINITIONS ##########
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/libressl/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/curl-openssl/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
export PATH=/usr/local/anaconda3/bin:"$PATH"

########## GRAPHWIZ ##########
export GRAPHVIZ_DOT=/usr/local/Cellar/graphviz/2.40.1_1/bin/dot

########## Fuzzy Finder ##########
export FZF_BASE=$(which fzf)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

########## ITERM ##########
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

########## PYTHON ##########
# ASDF python patch required for mac 10.11: https://github.com/danhper/asdf-python
export ASDF_PYTHON_PATCH_URL="https://github.com/python/cpython/commit/8ea6353.patch?full_index=1"
# Python System Environment Variables
export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
export CFLAGS="-I/usr/local/opt/sqlite/include -I/usr/local/opt/openssl/include -I/usr/local/opt/readline/include -I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export LDFLAGS="-L/usr/local/opt/sqlite/lib -L/usr/local/opt/openssl/lib -L/usr/local/opt/readline/lib"

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
. /usr/local/opt/asdf/asdf.sh
export PATH="$PATH:$(asdf where nodejs)/.npm/bin"
. ~/.asdf/plugins/java/set-java-home.zsh

# DIRENV Integration: https://github.com/asdf-community/asdf-direnv
eval "$(direnv hook zsh)"

########## BROOT ##########
# https://github.com/Canop/broot
source "/Users/${DEFAULT_USER}/.config/broot/launcher/bash/br"
