#{{{                    MARK:alias
#**************************************************************
alias glgf='git log --stat --format=fuller'

alias glu='git pull upstream'
alias glr='git pull --rebase'
alias glrf='git pull --rebase --force'

alias glom='git pull origin master:master'
alias glrom='git pull --rebase origin master:master'

alias glum='git pull upstream master:master'
alias glrum='git pull --rebase upstream master:master'

alias glod='git pull origin dev:dev'
alias glrod='git pull --rebase origin dev:dev'

alias glud='git pull upstream dev:dev'
alias glrud='git pull --rebase upstream dev:dev'

alias glomd='git pull origin master:dev'
alias gludm='git pull upstream dev:master'

alias glromd='git pull --rebase origin master:dev'
alias glrudm='git pull --rebase upstream dev:master'

alias glodm='git pull origin dev:master'
alias glumd='git pull upstream master:dev'

alias glrodm='git pull --rebase origin dev:master'
alias glrumd='git pull --rebase upstream master:dev'

alias grr='git remote remove'
alias gre='git remote rename'
alias grao='git remote add origin'
alias grau='git remote add upstream'

alias gpa='git push --all'
alias gpo='git push origin'
alias gpoa='git push origin --all'
alias gpfoa='git push --force origin --all'
alias gpu='git push upstream'
alias gpom='git push origin master:master'
alias gpum='git push upstream master:master'
alias gpod='git push origin dev:dev'
alias gpud='git push upstream dev:dev'

alias gpot='git push origin --tags'
alias gpfot='git push --force origin --tags'
alias gput='git push upstream --tags'
alias gpfut='git push --force upstream --tags'

alias glfo='git pull --force origin'
alias glrfo='git pull --rebase --force origin'

alias glfu='git pull --force upstream'
alias glrfu='git pull --rebase --force upstream'

alias glfom='git pull --force origin master:master'
alias glrfom='git pull --rebase --force origin master:master'

alias glfum='git pull --force upstream master:master'
alias glrfum='git pull --rebase --force upstream master:master'

alias glfod='git pull --force origin dev:dev'
alias glfud='git pull --force upstream dev:dev'

alias glrfod='git pull --rebase --force origin dev:dev'
alias glrfud='git pull --rebase --force upstream dev:dev'

alias glfomd='git pull --force origin master:dev'
alias glfudm='git pull --force upstream dev:master'

alias glrfomd='git pull --rebase --force origin masterdev'
alias glrfudm='git pull --rebase --force upstream dev:master'

alias glfodm='git pull --force origin dev:master'
alias glfumd='git pull --force upstream masterdev'

alias glrfodm='git pull --rebase --force origin dev:master'
alias glrfumd='git pull --rebase --force upstream masterdev'

alias gpfo='git push --force origin'
alias gpfu='git push --force upstream'

alias gpfom='git push --force origin master:master'
alias gpfod='git push --force origin dev:dev'

alias gpfum='git push --force upstream master:master'
alias gpfud='git push --force upstream dev:dev'

alias gpfomd='git push --force origin master:dev'
alias gpfodm='git push --force origin dev:master'

alias gpfumd='git push --force upstream master:dev'
alias gpfudm='git push --force upstream dev:master'

alias gpuat='git push upstream --all && git push upstream --tags'

alias gpfoat='git push -f origin --all && git push -f origin --tags'
alias gpfuat='git push -f upstream --all && git push -f origin --tags'

alias grom='git reset --hard origin/master'
alias grum='git reset --hard upstream/master'
alias grod='git reset --hard origin/dev'
alias grud='git reset --hard upstream/dev'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gfod='git fetch origin dev'
alias gfud='git fetch upstream dev'
alias gfom='git fetch origin master'
alias gfum='git fetch upstream master'
alias gffo='git fetch --force origin'
alias gffu='git fetch --force upstream'
alias gffod='git fetch --force origin dev'
alias gffud='git fetch --force upstream dev'
alias gffom='git fetch --force origin master'
alias gffum='git fetch --force upstream master'
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
(( $+functions[exists] )) ||
exists(){
    #alternative is command -v
    type "$1" >/dev/null 2>&1
}

(( $+functions[isGitDir] )) ||
isGitDir(){
    command git rev-parse --git-dir 2> /dev/null 1>&2
}

(( $+functions[loggErr] )) ||
loggErr(){
    test -z "$1" && loggErr "need arg" >&2 && return 1
    {
        printf "ERROR: $@"
    } >&2
}

(( $+functions[loggNotGit] )) ||
loggNotGit() {

    loggErr "$(pwd) is not a git dir"
}

gitCommitAndPush(){

    local dir remotes currentDir

    if [[ -z "$1" ]]; then
        loggErr "No commit message"
        return 1
    fi

    if ! isGitDir; then
        loggNotGit
        return 1
    fi

	git status | grep -q "nothing to commit" && {
        loggErr "Nothing to commit"
        return 1
	}

    remotes=$(git remote)
    currentDir="$(pwd -P)"
    for dir in "${BLACKLISTED_DIRECTORIES[@]}" ; do
       if [[ "$currentDir" == "$dir" ]]; then
           return 1
       fi
    done

    echo

    if [[ -n $remotes ]]; then
        git pull --no-rebase
    fi

    git add .
    git commit -m "$1"

    if [[ -n $remotes ]]; then
        git push
    fi
}

gitFunc() {
    emulate -LR zsh

    local currentDir dir __old

    currentDir="$(pwd -P)"
    for dir in "${BLACKLISTED_DIRECTORIES[@]}" ; do
        if [[ "$currentDir" == "$dir" ]]; then
            print -sr "$BUFFER"
            loggErr "BLACKLISTED: $(pwd -P)"
            zle .kill-whole-line
            zle .accept-line
            return 1
        fi
    done

    if ! isGitDir; then
        loggNotGit
        zle .kill-whole-line
        zle .accept-line-and-down-history
        return 1
    fi

    print -r -- "$BUFFER" | grep -q -E '\S' || {
        print -sr "$BUFFER"
        loggErr "No commit message"
        zle .kill-whole-line
        zle .accept-line
        zle .accept-line-and-down-history
        return 1
    }
    #leaky simonoff theme so reset ANSI escape sequences
	git add .

	git status | grep -q "nothing to commit" && {
        print -sr "$BUFFER"
        loggErr "Nothing to commit"
        zle .kill-whole-line
        zle .accept-line
        return 1
	}

     __old="$LESS"
    unset LESS

    if exists gitSdiffColorizer.pl;then
        gitSdiffColorizer.pl | less -R
    else
        git difftool -y -x HEAD * | less -R
    fi

    export LESS="$__old"

    echo
    printf "\x1b[4;34m>>>>>> Push? \x1b[0m"
    if echo "$SHELL" | grep -q zsh ; then
        read -k 1
    else
        read -n 1
    fi

    if [[ "$REPLY" == 'y' ]]; then
        # blue foreground color git info
        printf "\x1b[0;34m"
        gitCommitAndPush "$BUFFER" && {
            print -sr "$BUFFER"
            zle .kill-whole-line
            printf "\x1b[0m"
            zle .redisplay
        }
    else
            print -sr "$BUFFER"
            echo
            zle .kill-whole-line
            printf "\x1b[0m"
            zle .redisplay
    fi
}

gitFuncNoCheck() {
    emulate -LR zsh

    local currentDir dir remotes

    currentDir="$(pwd -P)"
    for dir in "${BLACKLISTED_DIRECTORIES[@]}" ; do
        if [[ "$currentDir" == "$dir" ]]; then
            print -sr "$BUFFER"
            loggErr "BLACKLISTED: $(pwd -P)"
            zle .kill-whole-line
            zle .accept-line
            return 1
        fi
    done

    if ! isGitDir; then
        loggNotGit
        zle .kill-whole-line
        zle .accept-line-and-down-history
        return 1
    fi

    print -r -- "$BUFFER" | grep -q -E '\S' || {
        print -sr "$BUFFER"
        loggErr "No commit message"
        zle .kill-whole-line
        zle .accept-line
        zle .accept-line-and-down-history
        return 1
    }

	git status | grep -q "nothing to commit" && {
        print -sr "$BUFFER"
        loggErr "Nothing to commit"
        zle .kill-whole-line
        zle .accept-line
        return 1
	}
    #leaky simonoff theme so reset ANSI escape sequences
    # blue foreground color git info
    printf "\x1b[0;34m"
	if gitCommitAndPush "$BUFFER";then
		print -sr "$BUFFER"
		zle .kill-whole-line
		printf "\x1b[0m"
		zle .redisplay
    fi

}
#}}}***********************************************************

#{{{                    MARK:ZLE keybind
#**************************************************************
zle -N gitFunc
zle -N gitFuncNoCheck

bindkey -M viins '^S' gitFuncNoCheck
bindkey -M vicmd '^S' gitFuncNoCheck
bindkey -M viins '^F^S' gitFunc
bindkey -M vicmd '^F^S' gitFunc
#}}}***********************************************************

