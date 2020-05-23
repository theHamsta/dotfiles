alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'

alias gd='git diff'

alias gf='git fetch'

alias gl='git pull'

alias gm='git merge'

alias gp='git push'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias glog='git log --oneline --decorate --graph'

alias ls=exa
alias tree="exa --tree"

alias i="sudo apt install"
alias r="sudo apt remove"
alias apt="sudo apt"
alias autoremove="sudo apt auto-remove"
alias g="sudo apt update && apt upgrade"

alias vi=nvim
alias vim=nvim



alias ju='just --justfile ~/.justfile --working-directory .'

egrep "^export " ~/.profile | while read e
    set var (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\1/")
    set value (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\2/")

    # remove surrounding quotes if existing
    set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    if test $var = "PATH"
        # replace ":" by spaces. this is how PATH looks for Fish
        set value (echo $value | sed -E "s/:/ /g")

        # use eval because we need to expand the value
        eval set -xg $var $value

        continue
    end

    # evaluate variables. we can use eval because we most likely just used "$var"
    set value (eval echo $value)

    set -xg $var $value
end
