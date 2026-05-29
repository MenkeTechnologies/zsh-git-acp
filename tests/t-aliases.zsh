#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### Purpose: alias-presence + key-function-presence pins for
#####          zsh-git-acp. The plugin registers ~159 git aliases
#####          + 4 helper fns; these tests pin a meaningful subset
#####          so renaming or accidental-removal lands as a CI failure.
#}}}***********************************************************

@setup {
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
}

@test 'sourcing the plugin registers more than 100 g* aliases' {
    local count
    count=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias | grep -cE '^g[a-z]+='
    ")
    # zunit lacks `greater_than`; do it manually with a binary signal.
    local result=$([[ "$count" -ge 100 ]] && echo yes || echo no)
    assert "$result" same_as 'yes'
}

@test 'flagship alias gacp resolves to git add + commit + push pipeline' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias gacp
    ")
    assert "$body" contains 'git add'
    assert "$body" contains 'git commit'
    assert "$body" contains 'git push'
}

@test 'helper fn zsh-gacp-mainBranch is defined' {
    local out
    out=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        typeset -f zsh-gacp-mainBranch >/dev/null && echo defined
    ")
    assert "$out" same_as 'defined'
}

@test 'helper fn zsh-gacp-devBranch is defined' {
    local out
    out=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        typeset -f zsh-gacp-devBranch >/dev/null && echo defined
    ")
    assert "$out" same_as 'defined'
}

@test 'gbuom references origin remote' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias gbuom
    ")
    assert "$body" contains 'origin'
}

@test 'gbuod references origin remote' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias gbuod
    ")
    assert "$body" contains 'origin'
}

@test 'gbuum references upstream remote' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias gbuum
    ")
    assert "$body" contains 'upstream'
}

@test 'gbuud references upstream remote' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias gbuud
    ")
    assert "$body" contains 'upstream'
}

@test 'gpf carries --force flag' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias gpf
    ")
    assert "$body" contains '--force'
}

@test 'gpfsup carries --force and --set-upstream and resolves to current HEAD' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias gpfsup
    ")
    assert "$body" contains '--force'
    assert "$body" contains '--set-upstream'
    assert "$body" contains 'symbolic-ref'
}

@test 'glgf is a git log variant with --stat' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias glgf
    ")
    assert "$body" contains 'log'
    assert "$body" contains '--stat'
}

@test 'gcom switches to main branch (checkout, not commit)' {
    # Pin so a refactor can't accidentally rebind gcom to "git commit"
    # — real risk because the name overlaps.
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias gcom
    ")
    assert "$body" contains 'checkout'
    assert "$body" contains 'mainBranch'
}

@test 'plugin sourcing is idempotent — alias count unchanged after re-source' {
    local first second
    first=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias | grep -cE '^g[a-z]+='
    ")
    second=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        source '$pluginDir/zsh-git-acp.plugin.zsh' 2>/dev/null
        alias | grep -cE '^g[a-z]+='
    ")
    assert "$first" equals "$second"
}
