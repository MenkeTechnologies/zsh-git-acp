# zsh-git-acp
This plugin adds various git aliases and two zle keybindings.

## keybindings
The zle keybindings both take the current BUFFER as the commit message and then run git add, commit and push hence the name git-acp.
This the is the gitFunc widget bound to ^S (like many apps bind save from menus).  There is no confirmation before the add, commit and push.
The gitFuncNoCheck widget does the same but only after a side by side diff piped into less and a confirmation prompt.
This is bound to ^F^S.

```sh
bindkey -M viins '^S' gitFuncNoCheck
bindkey -M vicmd '^S' gitFuncNoCheck
bindkey -M viins '^F^S' gitFunc
bindkey -M vicmd '^F^S' gitFunc
bindkey -M viins '^S' gitFuncNoCheck
bindkey -M vicmd '^S' gitFuncNoCheck
bindkey -M viins '^F^S' gitFunc
bindkey -M vicmd '^F^S' gitFunc
```

## 56 git aliases

```sh
alias gil='vim .git/info/exclude'
alias glu='git pull upstream'
alias glom='git pull origin master'
alias glum='git pull upstream master'
alias glod='git pull origin dev'
alias glud='git pull upstream dev'
alias gpo='git push origin'
alias gpu='git push upstream'
alias gpom='git push origin master:master'
alias gpum='git push upstream master:master'
alias gpod='git push origin dev'
alias gpud='git push upstream dev'
alias glfo='git pull --force origin'
alias glfu='git pull --force upstream'
alias glfom='git pull --force origin master'
alias glfum='git pull --force upstream master'
alias glfod='git pull --force origin dev'
alias glfud='git pull --force upstream dev'
alias gpfo='git push --force origin'
alias gpfu='git push --force upstream'
alias gpfom='git push --force origin master:master'
alias gpfum='git push --force upstream master:master'
alias gpfod='git push --force origin dev'
alias gpfud='git push --force upstream dev'
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
```


## Install for Oh My Zsh

```sh
cd "$HOME/.oh-my-zsh/custom/plugins" && git clone https://github.com/MenkeTechnologies/zsh-git-acp.git
```

Add `zsh-git-acp` to plugins array in ~/.zshrc

## General Install

```sh
git clone https://github.com/MenkeTechnologies/zsh-git-acp.git
```

source zsh-git-acp.plugin.zsh from .zshrc

