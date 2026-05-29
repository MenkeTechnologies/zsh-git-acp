#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: zsh-git-acp — second-tier contract pins.
#####          Cover the ZLE widget registrations, bindkey wiring
#####          on viins/vicmd/emacs for both Ctrl-S and Ctrl-F Ctrl-S,
#####          setopt noflowcontrol (frees Ctrl-S from XOFF), and
#####          ZPWR_DEV_BRANCH / ZPWR_MAIN_BRANCH defaults.
#}}}***********************************************************

@setup {
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    pluginFile="$pluginDir/zsh-git-acp.plugin.zsh"
}

@test 'zle -N registers both NoCheck and CheckDiff widgets' {
    # Pin: the two widgets are the user-visible ZLE commands. Without
    # zle -N, the bindkey calls would attach to non-widget names and
    # silently fail at runtime.
    grep -qE '^zle -N zsh-gacp-NoCheck' "$pluginFile"
    assert $? equals 0
    grep -qE '^zle -N zsh-gacp-CheckDiff' "$pluginFile"
    assert $? equals 0
}

@test 'setopt noflowcontrol frees Ctrl-S from terminal XOFF' {
    # Pin: terminal default is Ctrl-S = XOFF (pause output). zsh-git-acp
    # binds Ctrl-S as its main shortcut; without the noflowcontrol opt
    # the binding never reaches ZLE and the user sees the terminal
    # freeze instead.
    grep -qE '^setopt noflowcontrol' "$pluginFile"
    assert $? equals 0
}

@test 'Ctrl-S (no-check commit) wired on viins AND vicmd AND emacs' {
    # Pin: 3-keymap wiring so the binding works regardless of editor
    # mode. Dropping any keymap silently strands users in that mode.
    grep -qE "bindkey -M viins '\^S' zsh-gacp-NoCheck" "$pluginFile"
    assert $? equals 0
    grep -qE "bindkey -M vicmd '\^S' zsh-gacp-NoCheck" "$pluginFile"
    assert $? equals 0
    grep -qE "bindkey -M emacs '\^S' zsh-gacp-NoCheck" "$pluginFile"
    assert $? equals 0
}

@test 'Ctrl-F Ctrl-S (CheckDiff) wired on viins AND vicmd AND emacs' {
    grep -qE "bindkey -M viins '\^F\^S' zsh-gacp-CheckDiff" "$pluginFile"
    assert $? equals 0
    grep -qE "bindkey -M vicmd '\^F\^S' zsh-gacp-CheckDiff" "$pluginFile"
    assert $? equals 0
    grep -qE "bindkey -M emacs '\^F\^S' zsh-gacp-CheckDiff" "$pluginFile"
    assert $? equals 0
}

@test 'ZPWR_DEV_BRANCH defaults to devBranch (the documented default)' {
    local out
    out=$(zsh -c "
        source '$pluginFile' 2>/dev/null
        print \"\$ZPWR_DEV_BRANCH\"
    ")
    assert "$out" same_as 'devBranch'
}

@test 'ZPWR_MAIN_BRANCH defaults to master (current state, pre-main migration)' {
    # Pin: the documented default. A flip to "main" without updating
    # all consumers would silently break the gcom/gcm aliases.
    local out
    out=$(zsh -c "
        source '$pluginFile' 2>/dev/null
        print \"\$ZPWR_MAIN_BRANCH\"
    ")
    assert "$out" same_as 'master'
}

@test 'BUG-PIN: helper fns redirect to /devBranch/null (typo, not /dev/null)' {
    # Pin: the source has `2> /devBranch/null` in zpwrExists and
    # zpwrIsGitDir at lines documented in the plugin. This is a typo
    # for `/dev/null` that survives because the redirect target is
    # silently created. Pin the current state so a fix to /dev/null
    # is a deliberate, reviewed change.
    local count
    count=$(grep -c '/devBranch/null' "$pluginFile" || true)
    [[ "$count" -ge 2 ]]
    assert $? equals 0
}
