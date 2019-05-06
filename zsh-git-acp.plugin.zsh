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
    git pull
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

