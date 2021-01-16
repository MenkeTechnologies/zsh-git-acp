0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
# util fns
fpath+=("${0:h}/autoload")
autoload -Uz "${0:h}/autoload/"*(.:t)


if [[ -z "$ZPWR_DEV_BRANCH" ]]; then
    ZPWR_DEV_BRANCH="dev"
fi

#{{{                    MARK:alias
#**************************************************************
alias gbuom="git branch -u origin/master"
alias gbuod="git branch -u origin/$ZPWR_DEV_BRANCH"

alias gbu="git branch -u"

alias gbuum="git branch -u upstream/master"
alias gbuud="git branch -u upstream/$ZPWR_DEV_BRANCH"

alias glgf="git log --stat --format=fuller"
alias gsa="git rev-list --all | xargs git grep -C 5"

alias gmc="git merge --continue"
alias gme="git merge --edit"
alias gmod="git merge origin/$ZPWR_DEV_BRANCH"

alias gdom="git diff -w origin/master"
alias gdod="git diff -w origin/$ZPWR_DEV_BRANCH"
alias gdum="git diff -w upstream/master"
alias gdud="git diff -w upstream/$ZPWR_DEV_BRANCH"

alias gcof="git checkout -f"
alias gcom="git checkout master"
alias gcoom="git checkout origin/master"
alias gcofom="git checkout -f origin/master"
alias gcood="git checkout origin/$ZPWR_DEV_BRANCH"
alias gcod="git checkout $ZPWR_DEV_BRANCH"
alias gcofod="git checkout -f origin/$ZPWR_DEV_BRANCH"

alias gcoum="git checkout upstream/master"
alias gcofum="git checkout -f upstream/master"
alias gcoud="git checkout upstream/$ZPWR_DEV_BRANCH"
alias gcofud="git checkout -f upstream/$ZPWR_DEV_BRANCH"

alias glu="git pull upstream"
alias glr="git pull --rebase"
alias glrf="git pull --rebase --force"

alias glhm="git pull heroku master:master"
alias glfhm="git pull -f heroku master:master"
alias glrhm="git pull --rebase heroku master:master"

alias glom="git pull origin master:master"
alias glrom="git pull --rebase origin master:master"

alias glum="git pull upstream master:master"
alias glrum="git pull --rebase upstream master:master"

alias glod="git pull origin $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"
alias glrod="git pull --rebase origin $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"

alias glud="git pull upstream $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"
alias glrud="git pull --rebase upstream $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"

alias glomd="git pull origin master:$ZPWR_DEV_BRANCH"
alias gludm="git pull upstream $ZPWR_DEV_BRANCH:master"

alias glromd="git pull --rebase origin master:$ZPWR_DEV_BRANCH"
alias glrudm="git pull --rebase upstream $ZPWR_DEV_BRANCH:master"

alias glodm="git pull origin $ZPWR_DEV_BRANCH:master"
alias glumd="git pull upstream master:$ZPWR_DEV_BRANCH"

alias glrodm="git pull --rebase origin $ZPWR_DEV_BRANCH:master"
alias glrumd="git pull --rebase upstream master:$ZPWR_DEV_BRANCH"

alias grr="git remote remove"
alias gre="git remote rename"
alias grao="git remote add origin"
alias grau="git remote add upstream"

alias gpa="git push --all"
alias gpo="git push origin"
alias gpoa="git push origin --all"
alias gpfoa="git push --force origin --all"
alias gpu="git push upstream"

alias gpom="git push origin master:master"
alias gpod="git push origin $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"
alias gpomd="git push origin master:$ZPWR_DEV_BRANCH"
alias gpodm="git push origin $ZPWR_DEV_BRANCH:master"

alias gpum="git push upstream master:master"
alias gpud="git push upstream $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"
alias gpumd="git push upstream master:$ZPWR_DEV_BRANCH"
alias gpudm="git push upstream $ZPWR_DEV_BRANCH:master"

alias gphm="git push heroku master:master"
alias gpfhm="git push --force heroku master:master"
alias gpfha="git push --force heroku --all"

alias gpot="git push origin --tags"
alias gpfot="git push --force origin --tags"
alias gput="git push upstream --tags"
alias gpfut="git push --force upstream --tags"

alias glfo="git pull --force origin"
alias glrfo="git pull --rebase --force origin"

alias glfu="git pull --force upstream"
alias glrfu="git pull --rebase --force upstream"

alias glfom="git pull --force origin master:master"
alias glrfom="git pull --rebase --force origin master:master"

alias glfum="git pull --force upstream master:master"
alias glrfum="git pull --rebase --force upstream master:master"

alias glfod="git pull --force origin $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"
alias glfud="git pull --force upstream $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"

alias glrfod="git pull --rebase --force origin $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"
alias glrfud="git pull --rebase --force upstream $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"

alias glfomd="git pull --force origin master:$ZPWR_DEV_BRANCH"
alias glfudm="git pull --force upstream $ZPWR_DEV_BRANCH:master"

alias glrfomd="git pull --rebase --force origin master:$ZPWR_DEV_BRANCH"
alias glrfudm="git pull --rebase --force upstream $ZPWR_DEV_BRANCH:master"

alias glfodm="git pull --force origin $ZPWR_DEV_BRANCH:master"
alias glfumd="git pull --force upstream master:$ZPWR_DEV_BRANCH"

alias glrfodm="git pull --rebase --force origin $ZPWR_DEV_BRANCH:master"
alias glrfumd="git pull --rebase --force upstream master:$ZPWR_DEV_BRANCH"

alias gpfo="git push --force origin"
alias gpfu="git push --force upstream"

alias gpfom="git push --force origin master:master"
alias gpfod="git push --force origin $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"

alias gpfum="git push --force upstream master:master"
alias gpfud="git push --force upstream $ZPWR_DEV_BRANCH:$ZPWR_DEV_BRANCH"

alias gpfomd="git push --force origin master:$ZPWR_DEV_BRANCH"
alias gpfodm="git push --force origin $ZPWR_DEV_BRANCH:master"

alias gpfumd="git push --force upstream master:$ZPWR_DEV_BRANCH"
alias gpfudm="git push --force upstream $ZPWR_DEV_BRANCH:master"

alias gpuat="git push upstream --all && git push upstream --tags"

alias gpfoat="git push -f origin --all && git push -f origin --tags"
alias gpfuat="git push -f upstream --all && git push -f origin --tags"

alias grom="git reset --hard origin/master"
alias grum="git reset --hard upstream/master"
alias grod="git reset --hard origin/$ZPWR_DEV_BRANCH"
alias grud="git reset --hard upstream/$ZPWR_DEV_BRANCH"
alias gfo="git fetch origin"
alias gfu="git fetch upstream"
alias gfod="git fetch origin $ZPWR_DEV_BRANCH"
alias gfud="git fetch upstream $ZPWR_DEV_BRANCH"
alias gfom="git fetch origin master"
alias gfum="git fetch upstream master"
alias gffo="git fetch --force origin"
alias gffu="git fetch --force upstream"
alias gffod="git fetch --force origin $ZPWR_DEV_BRANCH"
alias gffud="git fetch --force upstream $ZPWR_DEV_BRANCH"
alias gffom="git fetch --force origin master"
alias gffum="git fetch --force upstream master"
alias gj="git pull --rebase --autostash -v"
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

