# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/KartikAyalasomayajula/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/KartikAyalasomayajula/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/KartikAyalasomayajula/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/KartikAyalasomayajula/.fzf/shell/key-bindings.bash"
