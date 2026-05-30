#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: zsh-git-acp — third-tier surface pins:
#####          - mainBranch fallback list covers both `master` and `main` (post-2020 default)
#####          - devBranch fallback list covers development/develop/devel (the 3 common names)
#####          - mainBranch / devBranch return 1 outside a git dir (early-exit contract)
#####          - flagship `gacp` alias chains via `&&` (NOT `;`) so failure stops the chain
#####          - every autoload helper file ends with `<fnName> "$@"` (self-invocation)
#}}}***********************************************************

@setup {
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    pluginFile="$pluginDir/zsh-git-acp.plugin.zsh"
    autoloadDir="$pluginDir/autoload"
}

@test 'mainBranch fallback covers BOTH master AND main (post-2020 GitHub default)' {
    # Pin: GitHub renamed default to `main` in 2020. The fallback list MUST
    # include both so legacy and current repos resolve correctly. Dropping
    # `main` silently breaks every repo created after Oct-2020.
    local fnFile="$autoloadDir/zsh-gacp-mainBranch"
    grep -qE 'for branch in (master main|main master)' "$fnFile"
    assert $? equals 0
}

@test 'devBranch fallback covers the 3 common dev-branch names (development/develop/devel)' {
    # Pin: dev branches go by many names. The fallback MUST include the
    # 3 most common — dropping any silently breaks completion for that
    # convention.
    local fnFile="$autoloadDir/zsh-gacp-devBranch"
    local missing="" name
    for name in development develop devel; do
        grep -qE "\\b$name\\b" "$fnFile" || missing="$missing $name"
    done
    assert "$missing" is_empty
}

@test 'mainBranch returns 1 outside a git dir (early-exit guard)' {
    # Pin: invoking mainBranch outside a git dir must return non-zero
    # without producing spurious output. Otherwise aliases like
    # `gbuom='git branch -u origin/$(zsh-gacp-mainBranch)'` resolve to
    # `git branch -u origin/master` on a non-repo and silently fail.
    local fnFile="$autoloadDir/zsh-gacp-mainBranch"
    grep -qE 'git rev-parse --git-dir &>/dev/null \|\| return 1' "$fnFile"
    assert $? equals 0
}

@test 'flagship gacp alias chains via && (failure stops chain, NOT semicolon)' {
    # Pin: `git add && git commit && git push` — if `add` fails, commit
    # MUST not fire. With `;` chaining, every step runs unconditionally,
    # which can push partial state on a broken add.
    local body
    body=$(zsh -c "
        source '$pluginFile' 2>/dev/null
        alias gacp
    ")
    [[ "$body" == *'&&'* ]]
    assert $state equals 0
}

@test 'BUG-PIN: zsh-gacp-CommitCount ends with wrong self-invocation (calls CommitAndPush)' {
    # BUG: autoload/zsh-gacp-CommitCount tails with
    #   zsh-gacp-CommitAndPush "$@"
    # instead of
    #   zsh-gacp-CommitCount "$@"
    # On autoload-trigger, the wrong function fires — silently committing
    # AND pushing when the user just wanted a commit count. Pin documents
    # the current broken behavior so a real fix flips this test.
    local fnFile="$autoloadDir/zsh-gacp-CommitCount"
    local last
    last=$(grep -vE '^\s*$|^#' "$fnFile" | tail -1)
    assert "$last" same_as 'zsh-gacp-CommitAndPush "$@"'
}

