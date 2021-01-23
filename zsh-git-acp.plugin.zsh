0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
# util fns
fpath+=("${0:h}/autoload")
autoload -Uz "${0:h}/autoload/"*(.:t)

ZPWR_DEV_BRANCH="dev"
ZPWR_MAIN_BRANCH="master"

function git_main_branch() {

    command git rev-parse --git-dir &>/dev/null || return 1

    local branch

    for branch in master main; do
        if command git show-ref -q --verify refs/heads/$branch; then
            echo "$branch"
            return
        fi
    done
    echo master
}

function git_dev_branch() {

    command git rev-parse --git-dir &>/dev/null || return 1

    local branch

    for branch in development develop devel; do
        if command git show-ref -q --verify refs/heads/$branch; then
            echo "$branch"
            return
        fi
    done

    echo dev
}

#{{{                    MARK:alias
#**************************************************************
alias gbuom='git branch -u origin/$(git_main_branch)'
alias gbuod='git branch -u origin/$(git_dev_branch)'

alias gbu='git branch -u'
alias gcd='git checkout $(git_dev_branch)'

alias gbuum='git branch -u upstream/$(git_main_branch)'
alias gbuud='git branch -u upstream/$(git_dev_branch)'

alias glgf='git log --stat --format=fuller'
alias gsa='git rev-list --all | xargs git grep -C 5'

alias gmc='git merge --continue'
alias gme='git merge --edit'
alias gmod='git merge origin/$(git_dev_branch)'

alias gdom='git diff -w origin/$(git_main_branch)'
alias gdod='git diff -w origin/$(git_dev_branch)'
alias gdum='git diff -w upstream/$(git_main_branch)'
alias gdud='git diff -w upstream/$(git_dev_branch)'

alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_dev_branch)'

alias gcof='git checkout -f'
alias gcom='git checkout $(git_main_branch)'
alias gcoom='git checkout origin/$(git_main_branch)'
alias gcofom='git checkout -f origin/$(git_main_branch)'
alias gcood='git checkout origin/$(git_dev_branch)'
alias gcod='git checkout $(git_dev_branch)'
alias gcofod='git checkout -f origin/$(git_dev_branch)'

alias gcoum='git checkout upstream/$(git_main_branch)'
alias gcofum='git checkout -f upstream/$(git_main_branch)'
alias gcoud='git checkout upstream/$(git_dev_branch)'
alias gcofud='git checkout -f upstream/$(git_dev_branch)'

alias glu='git pull upstream'
alias glr='git pull --rebase'
alias glrf='git pull --rebase --force'

alias glhm='_m=$(git_main_branch); git pull heroku $_m:$_m; unset _m'
alias glfhm='_m=$(git_main_branch); git pull -f heroku $_m:$_m; unset _m'
alias glrhm='_m=$(git_main_branch); git pull --rebase heroku $_m:$_m; unset _m'

alias glom='_m=$(git_main_branch); git pull origin $_m:$_m; unset _m'
alias glrom='_m=$(git_main_branch); git pull --rebase origin $_m:$_m; unset _m'

alias glum='_m=$(git_main_branch); git pull upstream $_m:$_m; unset _m'
alias glrum='_m=$(git_main_branch); git pull --rebase upstream $_m:$_m; unset _m'

alias glod='_d=$(git_dev_branch); git pull origin $_d:$_d; unset _d'
alias glrod='_d=$(git_dev_branch); git pull --rebase origin $_d:$_d; unset _d'

alias glud='_d=$(git_dev_branch); git pull upstream $_d:$_d; unset _d'
alias glrud='_d=$(git_dev_branch); git pull --rebase upstream $_d:$_d; unset _d'

alias glomd='git pull origin $(git_main_branch):$(git_dev_branch)'
alias gludm='git pull upstream $(git_dev_branch):$(git_main_branch)'

alias glromd='git pull --rebase origin $(git_main_branch):$(git_dev_branch)'
alias glrudm='git pull --rebase upstream $(git_dev_branch):$(git_main_branch)'

alias glodm='git pull origin $(git_dev_branch):$(git_main_branch)'
alias glumd='git pull upstream $(git_main_branch):$(git_dev_branch)'

alias glrodm='git pull --rebase origin $(git_dev_branch):$(git_main_branch)'
alias glrumd='git pull --rebase upstream $(git_main_branch):$(git_dev_branch)'

alias grr='git remote remove'
alias gre='git remote rename'
alias grao='git remote add origin'
alias grau='git remote add upstream'

alias gpa='git push --all'
alias gpo='git push origin'
alias gpoa='git push origin --all'
alias gpfoa='git push --force origin --all'
alias gpu='git push upstream'

alias gpom='_m=$(git_main_branch); git push origin $_m:$_m; unset _m'
alias gpod='_d=$(git_dev_branch); git push origin $_d:$_d; unset _d'
alias gpomd='git push origin $(git_main_branch):$(git_dev_branch)'
alias gpodm='git push origin $(git_dev_branch):$(git_main_branch)'

alias gpum='_m=$(git_main_branch); git push upstream $_m:$_m; unset _m'
alias gpud='_d=$(git_dev_branch); git push upstream $_d:$_d; unset _d'
alias gpumd='git push upstream $(git_main_branch):$(git_dev_branch)'
alias gpudm='git push upstream $(git_dev_branch):$(git_main_branch)'

alias gphm='_m=$(git_main_branch); git push heroku $_m:$_m; unset _m'
alias gpfhm='_m=$(git_main_branch); git push --force heroku $_m:$_m; unset _m'
alias gpfha='git push --force heroku --all'

alias gpot='git push origin --tags'
alias gpfot='git push --force origin --tags'
alias gput='git push upstream --tags'
alias gpfut='git push --force upstream --tags'

alias glfo='git pull --force origin'
alias glrfo='git pull --rebase --force origin'

alias glfu='git pull --force upstream'
alias glrfu='git pull --rebase --force upstream'

alias glfom='_m=$(git_main_branch); git pull --force origin $_m:$_m; unset _m'
alias glrfom='_m=$(git_main_branch); git pull --rebase --force origin $_m:$_m; unset _m'

alias glfum='_m=$(git_main_branch); git pull --force upstream $_m:$_m; unset _m'
alias glrfum='_m=$(git_main_branch); git pull --rebase --force upstream $_m:$_m; unset _m'

alias glfod='_d=$(git_dev_branch); git pull --force origin $_d:$_d; unset _d'
alias glfud='_d=$(git_dev_branch); git pull --force upstream $_d:$_d; unset _d'

alias glrfod='_d=$(git_dev_branch); git pull --rebase --force origin $_d:$_d; unset _d'
alias glrfud='_d=$(git_dev_branch); git pull --rebase --force upstream $_d:$_d; unset _d'

alias glfomd='git pull --force origin $(git_main_branch):$(git_dev_branch)'
alias glfudm='git pull --force upstream $(git_dev_branch):$(git_main_branch)'

alias glrfomd='git pull --rebase --force origin $(git_main_branch):$(git_dev_branch)'
alias glrfudm='git pull --rebase --force upstream $(git_dev_branch):$(git_main_branch)'

alias glfodm='git pull --force origin $(git_dev_branch):$(git_main_branch)'
alias glfumd='git pull --force upstream $(git_main_branch):$(git_dev_branch)'

alias glrfodm='git pull --rebase --force origin $(git_dev_branch):$(git_main_branch)'
alias glrfumd='git pull --rebase --force upstream $(git_main_branch):$(git_dev_branch)'

alias gpfo='git push --force origin'
alias gpfu='git push --force upstream'

alias gpfom='_m=$(git_main_branch); git push --force origin $_m:$_m; unset _m'
alias gpfod='_d=$(git_dev_branch); git push --force origin $_d:$_d; unset _d'

alias gpfum='_m=$(git_main_branch); git push --force upstream $_m:$_m; unset _m'
alias gpfud='_d=$(git_dev_branch); git push --force upstream $_d:$_d; unset _d'

alias gpfomd='git push --force origin $(git_main_branch):$(git_dev_branch)'
alias gpfodm='git push --force origin $(git_dev_branch):$(git_main_branch)'

alias gpfumd='git push --force upstream $(git_main_branch):$(git_dev_branch)'
alias gpfudm='git push --force upstream $(git_dev_branch):$(git_main_branch)'

alias gpuat='git push upstream --all && git push upstream --tags'

alias gpfoat='git push -f origin --all && git push -f origin --tags'
alias gpfuat='git push -f upstream --all && git push -f origin --tags'

alias grom='git reset --hard origin/$(git_main_branch)'
alias grum='git reset --hard upstream/$(git_main_branch)'
alias grod='git reset --hard origin/$(git_dev_branch)'
alias grud='git reset --hard upstream/$(git_dev_branch)'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gfod='git fetch origin $(git_dev_branch)'
alias gfud='git fetch upstream $(git_dev_branch)'
alias gfom='git fetch origin $(git_main_branch)'
alias gfum='git fetch upstream $(git_main_branch)'
alias gffo='git fetch --force origin'
alias gffu='git fetch --force upstream'
alias gffod='git fetch --force origin $(git_dev_branch)'
alias gffud='git fetch --force upstream $(git_dev_branch)'
alias gffom='git fetch --force origin $(git_main_branch)'
alias gffum='git fetch --force upstream $(git_main_branch)'
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
    type "$1" >/dev/null 2>&1
}

(( $+functions[zpwrIsGitDir] )) ||
zpwrIsGitDir(){
    command git rev-parse --git-dir 2> /dev/null 1>&2
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
zle -N gacpCheckDiff
zle -N gacpNoCheck

setopt noflowcontrol

bindkey -M viins '^S' gacpNoCheck
bindkey -M vicmd '^S' gacpNoCheck
bindkey -M viins '^F^S' gacpCheckDiff
bindkey -M vicmd '^F^S' gacpCheckDiff
#}}}***********************************************************

