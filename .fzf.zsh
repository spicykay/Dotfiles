# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/"${DEFAULT_USER}"/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/${DEFAULT_USER}/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/${DEFAULT_USER}/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/${DEFAULT_USER}/.fzf/shell/key-bindings.zsh"
