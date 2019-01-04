# Setup fzf
# ---------
if [[ ! "$PATH" == */home/stephan/.fzf/bin* ]]; then
  export PATH="$PATH:/home/stephan/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/stephan/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/stephan/.fzf/shell/key-bindings.zsh"

