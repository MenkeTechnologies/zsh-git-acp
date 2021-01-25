0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
# util fns
fpath+=("${0:h}/autoload")
autoload -Uz "${0:h}/autoload/"*(.:t)

ZPWR_DEV_BRANCH="devBranch"
ZPWR_MAIN_BRANCH="master"

#{{{                    MARK:alias
#**************************************************************
alias gbuom='git branch -u origin/$(zsh-gacp-mainBranch)'
alias gbuod='git branch -u origin/$(zsh-gacp-devBranch)'

alias gbu='git branch -u'
alias gcd='git checkout $(zsh-gacp-devBranch)'

alias gbuum='git branch -u upstream/$(zsh-gacp-mainBranch)'
alias gbuud='git branch -u upstream/$(zsh-gacp-devBranch)'

alias glgf='git log --stat --format=fuller'
alias gsa='git rev-list --all | xargs git grep -C 5'

alias gmc='git merge --continue'
alias gme='git merge --edit'
alias gmod='git merge origin/$(zsh-gacp-devBranch)'

alias gdom='git diff -w origin/$(zsh-gacp-mainBranch)'
alias gdod='git diff -w origin/$(zsh-gacp-devBranch)'
alias gdum='git diff -w upstream/$(zsh-gacp-mainBranch)'
alias gdud='git diff -w upstream/$(zsh-gacp-devBranch)'

alias gcm='git checkout $(zsh-gacp-mainBranch)'
alias gcd='git checkout $(zsh-gacp-devBranch)'

alias gcof='git checkout -f'
alias gcom='git checkout $(zsh-gacp-mainBranch)'
alias gcoom='git checkout origin/$(zsh-gacp-mainBranch)'
alias gcofom='git checkout -f origin/$(zsh-gacp-mainBranch)'
alias gcood='git checkout origin/$(zsh-gacp-devBranch)'
alias gcod='git checkout $(zsh-gacp-devBranch)'
alias gcofod='git checkout -f origin/$(zsh-gacp-devBranch)'

alias gcoum='git checkout upstream/$(zsh-gacp-mainBranch)'
alias gcofum='git checkout -f upstream/$(zsh-gacp-mainBranch)'
alias gcoud='git checkout upstream/$(zsh-gacp-devBranch)'
alias gcofud='git checkout -f upstream/$(zsh-gacp-devBranch)'

alias glu='git pull upstream'
alias glr='git pull --rebase'
alias glrf='git pull --rebase --force'

alias glhm='_m=$(zsh-gacp-mainBranch); git pull heroku $_m:$_m; unset _m'
alias glfhm='_m=$(zsh-gacp-mainBranch); git pull -f heroku $_m:$_m; unset _m'
alias glrhm='_m=$(zsh-gacp-mainBranch); git pull --rebase heroku $_m:$_m; unset _m'

alias glom='_m=$(zsh-gacp-mainBranch); git pull origin $_m:$_m; unset _m'
alias glrom='_m=$(zsh-gacp-mainBranch); git pull --rebase origin $_m:$_m; unset _m'

alias glum='_m=$(zsh-gacp-mainBranch); git pull upstream $_m:$_m; unset _m'
alias glrum='_m=$(zsh-gacp-mainBranch); git pull --rebase upstream $_m:$_m; unset _m'

alias glod='_d=$(zsh-gacp-devBranch); git pull origin $_d:$_d; unset _d'
alias glrod='_d=$(zsh-gacp-devBranch); git pull --rebase origin $_d:$_d; unset _d'

alias glud='_d=$(zsh-gacp-devBranch); git pull upstream $_d:$_d; unset _d'
alias glrud='_d=$(zsh-gacp-devBranch); git pull --rebase upstream $_d:$_d; unset _d'

alias glomd='git pull origin $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'
alias gludm='git pull upstream $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'

alias glromd='git pull --rebase origin $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'
alias glrudm='git pull --rebase upstream $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'

alias glodm='git pull origin $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'
alias glumd='git pull upstream $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'

alias glrodm='git pull --rebase origin $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'
alias glrumd='git pull --rebase upstream $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'

alias grr='git remote remove'
alias gre='git remote rename'
alias grao='git remote add origin'
alias grau='git remote add upstream'

alias gpa='git push --all'
alias gpo='git push origin'
alias gpoa='git push origin --all'
alias gpfoa='git push --force origin --all'
alias gpu='git push upstream'

alias gpom='_m=$(zsh-gacp-mainBranch); git push origin $_m:$_m; unset _m'
alias gpod='_d=$(zsh-gacp-devBranch); git push origin $_d:$_d; unset _d'
alias gpomd='git push origin $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'
alias gpodm='git push origin $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'

alias gpum='_m=$(zsh-gacp-mainBranch); git push upstream $_m:$_m; unset _m'
alias gpud='_d=$(zsh-gacp-devBranch); git push upstream $_d:$_d; unset _d'
alias gpumd='git push upstream $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'
alias gpudm='git push upstream $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'

alias gphm='_m=$(zsh-gacp-mainBranch); git push heroku $_m:$_m; unset _m'
alias gpfhm='_m=$(zsh-gacp-mainBranch); git push --force heroku $_m:$_m; unset _m'
alias gpfha='git push --force heroku --all'

alias gpot='git push origin --tags'
alias gpfot='git push --force origin --tags'
alias gput='git push upstream --tags'
alias gpfut='git push --force upstream --tags'

alias glfo='git pull --force origin'
alias glrfo='git pull --rebase --force origin'

alias glfu='git pull --force upstream'
alias glrfu='git pull --rebase --force upstream'

alias glfom='_m=$(zsh-gacp-mainBranch); git pull --force origin $_m:$_m; unset _m'
alias glrfom='_m=$(zsh-gacp-mainBranch); git pull --rebase --force origin $_m:$_m; unset _m'

alias glfum='_m=$(zsh-gacp-mainBranch); git pull --force upstream $_m:$_m; unset _m'
alias glrfum='_m=$(zsh-gacp-mainBranch); git pull --rebase --force upstream $_m:$_m; unset _m'

alias glfod='_d=$(zsh-gacp-devBranch); git pull --force origin $_d:$_d; unset _d'
alias glfud='_d=$(zsh-gacp-devBranch); git pull --force upstream $_d:$_d; unset _d'

alias glrfod='_d=$(zsh-gacp-devBranch); git pull --rebase --force origin $_d:$_d; unset _d'
alias glrfud='_d=$(zsh-gacp-devBranch); git pull --rebase --force upstream $_d:$_d; unset _d'

alias glfomd='git pull --force origin $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'
alias glfudm='git pull --force upstream $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'

alias glrfomd='git pull --rebase --force origin $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'
alias glrfudm='git pull --rebase --force upstream $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'

alias glfodm='git pull --force origin $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'
alias glfumd='git pull --force upstream $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'

alias glrfodm='git pull --rebase --force origin $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'
alias glrfumd='git pull --rebase --force upstream $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'

alias gpfo='git push --force origin'
alias gpfu='git push --force upstream'

alias gpfom='_m=$(zsh-gacp-mainBranch); git push --force origin $_m:$_m; unset _m'
alias gpfod='_d=$(zsh-gacp-devBranch); git push --force origin $_d:$_d; unset _d'

alias gpfum='_m=$(zsh-gacp-mainBranch); git push --force upstream $_m:$_m; unset _m'
alias gpfud='_d=$(zsh-gacp-devBranch); git push --force upstream $_d:$_d; unset _d'

alias gpfomd='git push --force origin $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'
alias gpfodm='git push --force origin $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'

alias gpfumd='git push --force upstream $(zsh-gacp-mainBranch):$(zsh-gacp-devBranch)'
alias gpfudm='git push --force upstream $(zsh-gacp-devBranch):$(zsh-gacp-mainBranch)'

alias gpuat='git push upstream --all && git push upstream --tags'

alias gpfoat='git push -f origin --all && git push -f origin --tags'
alias gpfuat='git push -f upstream --all && git push -f origin --tags'

alias grom='git reset --hard origin/$(zsh-gacp-mainBranch)'
alias grum='git reset --hard upstream/$(zsh-gacp-mainBranch)'
alias grod='git reset --hard origin/$(zsh-gacp-devBranch)'
alias grud='git reset --hard upstream/$(zsh-gacp-devBranch)'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gfod='git fetch origin $(zsh-gacp-devBranch)'
alias gfud='git fetch upstream $(zsh-gacp-devBranch)'
alias gfom='git fetch origin $(zsh-gacp-mainBranch)'
alias gfum='git fetch upstream $(zsh-gacp-mainBranch)'
alias gffo='git fetch --force origin'
alias gffu='git fetch --force upstream'
alias gffod='git fetch --force origin $(zsh-gacp-devBranch)'
alias gffud='git fetch --force upstream $(zsh-gacp-devBranch)'
alias gffom='git fetch --force origin $(zsh-gacp-mainBranch)'
alias gffum='git fetch --force upstream $(zsh-gacp-mainBranch)'
alias gj='git pull --rebase --autostash -v'
alias gs="git difftool -y -x 'printf \"\\x1b[1;4m\$REMOTE\\x1b[0m\\x0a\";sdiff --expand-tabs -w '\$COLUMNS "
alias grhs='git reset --soft'
alias grhm='git reset --mixed'
alias gpf='git push --force'
alias gdh='git diff -w HEAD'
alias bk='git clean -dff && git reset --hard HEAD && git clean -dff'
alias bki='git clean -dffx && git reset --hard HEAD && git clean -dffx'
alias glf='git pull --force'
alias gla='git pull --all'
alias glat='git pull --all --tags'
alias glt='git pull --tags'

alias glot='git pull origin --tags'
alias glfot='git pull --force origin --tags'

alias glut='git pull upstream --tags'
alias glfut='git pull --force upstream --tags'

alias glfa='git pull --force --all'
alias glfat='git pull --force --all --tags'
alias glft='git pull --force --tags'
alias gld='git log --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat -p '
alias glaa='git log --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat -p --all'
alias glz='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat -p'
alias glzz='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat -p --all'
alias gacp='git add . && git commit -m "" && git push'
alias gac='git add . && git commit -m ""'
alias gbv='git branch -a -vv'
alias allRebase='git rebase -i $(git rev-list --max-parents=0 HEAD)'

alias gt='git tag'
alias gfa='git fetch --all --prune --tags'
alias gffa='git fetch -f --all --prune --tags'

#}}}***********************************************************

#{{{                    MARK:git fn
#**************************************************************
(( $+functions[zpwrExists] )) ||
zpwrExists(){
    #alternative is command -v
    type "$1" >/devBranch/null 2>&1
}

(( $+functions[zpwrIsGitDir] )) ||
zpwrIsGitDir(){

    command git rev-parse --git-dir 2> /devBranch/null 1>&2
}

(( $+functions[zpwrLoggErr] )) ||
zpwrLoggErr(){

    test -z "$1" && zpwrLoggErr "need arg" >&2 && return 1
    {
        printf "ERROR: $@"
    } >&2
}

(( $+functions[zpwrLoggNotGit] )) ||
zpwrLoggNotGit() {

    zpwrLoggErr "$(pwd) is not a git dir"
}

#}}}***********************************************************

#{{{                    MARK:ZLE keybind
#**************************************************************
zle -N zsh-gacp-CheckDiff
zle -N zsh-gacp-NoCheck

setopt noflowcontrol

bindkey -M viins '^S' zsh-gacp-NoCheck
bindkey -M vicmd '^S' zsh-gacp-NoCheck
bindkey -M viins '^F^S' zsh-gacp-CheckDiff
bindkey -M vicmd '^F^S' zsh-gacp-CheckDiff
#}}}***********************************************************

