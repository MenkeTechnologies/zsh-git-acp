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

alias gpa='git push --all'
alias gpo='git push origin'
alias gpoa='git push origin --all'
alias gpfoa='git push --force origin --all'
alias gpu='git push upstream'
alias gpom='git push origin master:master'
alias gpum='git push upstream master:master'
alias gpod='git push origin dev:dev'
alias gpud='git push upstream dev:dev'

alias glfo='git pull --force origin'
alias glrfo='git pull --rebase --force origin'

alias glfu='git pull --force upstream'
alias glrfu='git pull --rebase --force upstream'

alias glfom='git pull --force origin master:master'
alias glrfom='git pull --rebase --force origin master:master'

alias glfum='git pull --force upstream master:master'
alias glrfum='git pull --rebase --force upstream master:master'

alias glfod='git pull --force origin dev:dev'
alias glrfod='git pull --rebase --force origin dev:dev'

alias glfud='git pull --force upstream dev:dev'
alias glrfud='git pull --rebase --force upstream dev:dev'

alias gpfo='git push --force origin'
alias gpfu='git push --force upstream'
alias gpfom='git push --force origin master:master'
alias gpfum='git push --force upstream master:master'
alias gpfod='git push --force origin dev:dev'
alias gpfud='git push --force upstream dev:dev'
alias gpfoat='git push -f origin --all && git push -f origin --tags'
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
alias glf='git pull --force'
alias gla='git log --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat -p '
alias glaa='git log --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat -p --all'
alias glz='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat -p'
alias glzz='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat -p --all'
alias gacp='git add . && git commit -m "" && git push'
alias gac='git add . && git commit -m'
alias gbv='git branch -a -vv'
alias allRebase='git rebase -i $(git rev-list --max-parents=0 HEAD)'

exists(){
    #alternative is command -v
    type "$1" >/dev/null 2>&1
}

gitCommitAndPush(){
    currentDir="$(pwd -P)"
    for dir in "${BLACKLISTED_DIRECTORIES[@]}" ; do
       if [[ "$currentDir" == "$dir" ]]; then
           return 1
       fi
    done

    echo
    git pull --no-rebase
    git add .
    git commit -m "$1"
    git push
}

gitFunc() {
    emulate -LR zsh

    currentDir="$(pwd -P)"
    for dir in "${BLACKLISTED_DIRECTORIES[@]}" ; do
        if [[ "$currentDir" == "$dir" ]]; then
            printf "\x1b[0;1;31m"
            print -sr "$BUFFER"
            echo
            printf "BLACKLISTED: $(pwd -P)" >&2
            BUFFER=""
            printf "\x1b[0m"
            zle .accept-line
            return 1
        fi
    done

    git status &> /dev/null || {
        printf "\x1b[0;1;31m"
        print -sr "$BUFFER"
        printf "NOT GIT DIR: $(pwd -P)" >&2
        printf "\x1b[0m"
        zle .kill-whole-line
        zle .accept-line-and-down-history
        return 0
    }

    print -r -- "$BUFFER" | grep -q -E '\S' || {
        printf "\x1b[0;1;31m"
        print -sr "$BUFFER"
        printf "No commit message." >&2
        printf "\x1b[0m"
        zle .kill-whole-line
        zle .accept-line-and-down-history
        return 0
    }
    #leaky simonoff theme so reset ANSI escape sequences
	git add .

	git status | grep -q "nothing to commit" && {
        printf "\x1b[0;1;31m"
        print -sr "$BUFFER"
        echo
        printf "Nothing to commit" >&2
        echo
        BUFFER=""
        printf "\x1b[0m"
        zle .accept-line
        return 0
	}

    local __old="$LESS"
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
        printf "\x1b[34m"
        gitCommitAndPush "$BUFFER" && {
            print -sr "$BUFFER"
            zle .kill-whole-line
            printf "\x1b[0m"
            zle .redisplay
        } || {
            printf "\x1b[0;1;31m"
            print -sr "$BUFFER"
            printf "BLACKLISTED: $(pwd -P)" >&2
            BUFFER=""
            printf "\x1b[0m"
            zle .accept-line
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

    currentDir="$(pwd -P)"
    for dir in "${BLACKLISTED_DIRECTORIES[@]}" ; do
        if [[ "$currentDir" == "$dir" ]]; then
            printf "\x1b[0;1;31m"
            print -sr "$BUFFER"
            echo
            printf "BLACKLISTED: $(pwd -P)" >&2
            BUFFER=""
            printf "\x1b[0m"
            zle .accept-line
            return 1
        fi
    done

    git status &> /dev/null || {
        printf "\x1b[0;1;31m"
        print -sr "$BUFFER"
        printf "NOT GIT DIR: $(pwd -P)" >&2
        printf "\x1b[0m"
        zle .kill-whole-line
        zle .accept-line-and-down-history
        return 0
    }

    print -r -- "$BUFFER" | grep -q -E '\S' || {
        printf "\x1b[0;1;31m"
        print -sr "$BUFFER"
        printf "No commit message." >&2
        printf "\x1b[0m"
        zle .kill-whole-line
        zle .accept-line-and-down-history
        return 0
    }
    #leaky simonoff theme so reset ANSI escape sequences
    printf "\x1b[0;34m"
	if gitCommitAndPush "$BUFFER";then
		print -sr "$BUFFER"
		zle .kill-whole-line
		printf "\x1b[0m"
		zle .redisplay
    else
		printf "\x1b[0;1;31m"
		print -sr "$BUFFER"
		printf "BLACKLISTED: $(pwd -P)" >&2
		BUFFER=""
		printf "\x1b[0m"
		zle .accept-line
    fi

}

zle -N gitFunc
zle -N gitFuncNoCheck

bindkey -M viins '^S' gitFuncNoCheck
bindkey -M vicmd '^S' gitFuncNoCheck
bindkey -M viins '^F^S' gitFunc
bindkey -M vicmd '^F^S' gitFunc

