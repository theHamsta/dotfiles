# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="spaceship"
#ZSH_THEME="agnosterzak"

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
plugins=(git command-not-found extract history gitignore zoxide)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

alias -g ...='../..'
alias -g ....='../../..'
alias vi=nvim

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
alias gf="sudo apt-get upgrade -f"
alias distupgrade="sudo apt-get dist-upgrade -f"
alias i="sudo apt-get install "
alias ai="apt-cache show  "
alias r="sudo apt-get remove "
alias purge="sudo apt-get --purge remove "
alias aptsearch="apt-cache search "
alias autoremove="sudo apt-get autoremove"
alias apt="sudo apt"
alias autoremove="sudo apt autoremove"

alias cd..="cd .."
alias cd...="cd ../.."
alias -s tex=nvim
alias ls=exa
alias tree="exa --tree"

alias v='f -e nvim' # quick opening files with vim
alias o='a -e xdg-open' # quick opening files with xdg-open

#export CUDA_HOME=/usr/local/cuda-9.0
#export LD_LOAD_PATH=/usr/local/cuda-9.0/targets/x86_64-linux/lib/:${LD_LOAD_PATH}
#export LD_LIBRARY_PATH=/opt/ParaView-5.4.1-Qt5-OpenGL2-MPI-Linux-64bit/lib/paraview-5.4:${LD_LIBRARY_PATH}
export PATH=~/.local/bin/:${PATH}
export PATH=~/go/bin/:${PATH}
export GIT_EDITOR=nvim
#export LD_LIBRARY_PATH="/usr/local/cuda-9.1/lib/:/usr/local/cuda-9.1/targets/x86_64-linux/lib/:$LD_LIBRARY_PATH"
#export LD_LOAD_PATH="/usr/local/cuda-9.1/lib/:/usr/local/cuda-9.1/targets/x86_64-linux/lib/:$LD_LOAD_PATH"
export PATH=$PATH:/usr/local/cuda-9.1/bin
export PATH=/snap/bin/:${PATH}
#export CUDA_HOME=/usr/local/cuda-9.1

export SCIPY_PIL_IMAGE_VIEWER=imagecomparer

source ~/.profile



if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/stephan/go/bin/bitcomplete bit
test -r /home/stephan/.opam/opam-init/init.zsh && . /home/stephan/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

alias luamake=/home/stephan/projects/lua-language-server/3rd/luamake/luamake
