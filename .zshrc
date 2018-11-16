# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

SPACESHIP_TIME_SHOW=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_ADD_NEWLINE=false

#zle_highlight={default:bold}
 #POSTEDIT=$'\e[0m'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting colored-man-pages fasd  copydir command-not-found extract history cp gitignore pip zsh-256color compleat)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
command -v dtags-activate > /dev/null 2>&1 && eval "`dtags-activate zsh`"

alias l.='ls -d .* --color=auto'
alias up="sudo apt update"
alias g="sudo apt upgrade"
alias gf="sudo apt upgrade -f"
alias distupgrade="sudo apt dist-upgrade -f"
alias i="sudo apt-get install "
alias ai="apt-cache show  "
alias r="sudo apt-get remove "
alias purge="sudo apt-get --purge remove "
alias aptsearch="apt-cache search "
alias autoremove="sudo apt-get autoremove"
alias apt="sudo apt"
alias pro="cd ~/projects"

alias cd..="cd .."
alias cd...="cd ../.."

alias v='f -e nvim' # quick opening files with vim
alias o='a -e xdg-open' # quick opening files with xdg-open

export GOPATH=~/projects/go
export GIT_EDITOR=nvim
export LD_LOAD_PATH=/usr/local/cuda-8.0/targets/x86_64-linux/lib/:${LD_LOAD_PATH}
export PATH=~/bin/:~/.local/bin:${PATH}
export PATH=~/.roswell/bin/:~/.local/bin:${PATH}
export PATH=$GOPATH/bin:~/.local/bin:${PATH}
export PYTHONSTARTUP=~/.pythonrc

bindkey -M viins 'jk' vi-cmd-mode 

source "/home/stephan/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
