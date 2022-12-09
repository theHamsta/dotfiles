# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.  see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
#if [ -n "$BASH_VERSION" ]; then
    ## include .bashrc if it exists
    #if [ -f "$HOME/.bashrc" ]; then
	#. "$HOME/.bashrc"
    #fi
#fi

export DOCKER_BUILDKIT=1
# set PATH so it includes user's private bin directories
export GOPATH=$HOME/go
export PATH="/usr/local/cuda-11.1/bin:$PATH"
export PATH="/usr/local/cuda/bin:$PATH"
export PATH="/snap/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH=$HOME/opt/go/bin:$PATH
export PATH=$HOME/.roswell/bin:$PATH
export PATH=$HOME/opt/nvim-linux64/bin:$PATH
export PATH=/usr/lib/llvm-9/share/clang/:$PATH
export PATH="$HOME/opt/blender/:$PATH"
#export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export JAVA_HOME="/usr/lib/jvm/java-14-openjdk-amd64"
export PATH=/usr/lib/ccache:$PATH
export PATH=~/.cargo/bin:$PATH
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/projects/kotlin-language-server/server/build/install/server/bin/:$PATH"
export PATH="$HOME/.local/share/nvim/plugged/vim-iced/bin:$PATH"
export PATH="$HOME/rocks/luajit3.0/bin:$PATH"
export PATH="/opt/blender:$PATH"
#export PYTHONPATH="/usr/local/lib/python3.8/dist-packages:$HOME/projects/blender_autocomplete/2.80:$PYTHONPATH"
#export PYTHONPATH=/home/stephan/projects/walberla/debug-mpi/apps/pythonmodule:$PYTHONPATH
export PYTHONPATH="$HOME/projects/SimpleElastix/release/SimpleITK-build/Wrapping/Python:$PYTHONPATH"
#export PYTHONPATH="$HOME/.local/lib/python3.8/site-packages:$PYTHONPATH"
export OMP_NUM_THREADS=4

export CC=/usr/lib/ccache/clang-16
export CXX=/usr/lib/ccache/clang++-16
export OMPI_CC=/usr/lib/ccache/clang-16
export OMPI_CXX=/usr/lib/ccache/clang++-16
export MPICH_CC=/usr/lib/ccache/clang-16
export MPICH_CXX=/usr/lib/ccache/clang++-16

#export CC=/usr/lib/ccache/gcc-10
#export CXX=/usr/lib/ccache/g++-10
#export OMPI_CC=/usr/lib/ccache/gcc-10
#export OMPI_CXX=/usr/lib/ccache/g++-10
#export MPICH_CC=/usr/lib/ccache/gcc-10
#export MPICH_CXX=/usr/lib/ccache/g++-10

CUDA_PATH="/usr/local/cuda"
export PATH=$CUDA_PATH/bin:$PATH
export CUDACXX=/usr/local/cuda/bin/nvcc
export CUDACC=/usr/local/cuda/bin/nvcc

export CPATH=~/projects/nanogui/include:~/projects/nanogui/ext/enoki/include:~/projects/nanogui/ext/nanovg/src:$CPATH
export CPATH=/usr/include/x86_64-linux-gnu/mpich/:$CPATH
#export RUSTC_WRAPPER=sccache
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
export PATH=$PATH:$HOME/.luarocks/bin

export PATH=$HOME/.nimble/bin:$PATH
export PATH=$PATH:$HOME/projects/emsdk:$HOME/projects/emsdk/node/12.9.1_64bit/bin:$HOME/projects/emsdk/upstream/emscripten
export PATH=~/node_modules/.bin:$PATH
export PATH=./node_modules/.bin:$PATH
export PATH=/home/stephan/opt/julia-1.6.0/bin:$PATH



alias ju='just --justfile ~/.justfile --working-directory .'


export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

export GF_PREFERRED_PAGER="delta --theme=gruvbox --highlight-removed -w __WIDTH__"
export GO111MODULE=on
export RUSTFLAGS="-C target-cpu=native"

export HOMEBREW_EDITOR=nvim
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export GH_PAGER=

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
#export PATH="/home/stephan/opt/swift-5.3.2-RELEASE-ubuntu20.04/usr/bin/:$PATH"
export NeovideMultiGrid=true

export COMPlus_gcAllowVeryLargeObjects=1
