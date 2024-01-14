#zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export DISABLE_AUTO_UPDATE=1
fpath=($HOME/.zsh-completions $fpath)
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zoxide extract microk8s)

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export HISTFILE=~/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE

export CUDA_PATH=/usr/local/cuda
export PATH=~/.cargo/bin:$PATH
export PATH=$CUDA_PATH/bin:$PATH
export PATH=/snap/bin:$PATH
export PATH=/usr/lib/ccache/:$PATH
export PATH=~/go/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=$HOME/node_modules/.bin/:$PATH
export PATH=./node_modules/.bin:$PATH
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin

#export PATH=/media/other_linux/home/stephan/Downloads/nsight-systems-linux-internal-DVS/bin:$PATH
#export PATH=/opt/nvidia/nsight-systems/2021.3.1/bin:$PATH
#export PATH=$PATH:/opt/intel/oneapi/vtune/latest/bin64

alias vi=nvim
alias vim=nvim
alias apt="sudo apt"
alias autoremove="sudo apt autoremove"
alias i="sudo apt install"
alias r="sudo apt remove"
alias gr="sudo apt upgrade"
alias python="python3"
alias ls="eza"
alias ll="eza -l"

#eval $(minikube docker-env)
#alias helm="minikube helm"
#alias h="minikube helm"
#alias kubectl="minikube kubectl"
#alias k="minikube kubectl"
#alias wk="watch minikube kubectl"

alias helm="microk8s helm"
alias h="microk8s helm"
alias kubectl="microk8s kubectl"
alias k="microk8s kubectl"
alias wk="watch microk8s kubectl"

export CC=clang-18
export CXX=clang++-18
export CUDACC=nvcc
export CUDACXX=nvcc
export CUDAHOSTCXX=g++-11
export CPATH=$CUDA_PATH/targets/x86_64-linux/include/:$CPATH
export CMAKE_CUDA_COMPILER_LAUNCHER=ccache

export GO111MODULE=on
export DOCKER_BUILDKIT=1 

alias ju="just --justfile ~/.justfile --working-directory ."


export DOCKER_TMP=/other-linux/docker

source $HOME/.profile

alias luamake=/home/stephan/projects/lua-language-server/3rd/luamake/luamake
export PATH="$PATH:/home/stephan"
export PATH="$PATH:$HOME/.yarn/bin/"

export CUDA_MODULE_LOADING=LAZY  

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export WEBKIT_DISABLE_DMABUF_RENDERER=1

eval "$(starship init zsh)"
#zprof

