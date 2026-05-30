#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: zsh-git-acp — fourth-tier contracts.
#####          Pins for CommitAndPush ordering: empty-message early
#####          return, no-git-dir guard, nothing-to-commit guard,
#####          blacklisted-directory skip, and the canonical sequence
#####          pull-rebase then add then commit then push when remotes
#####          exist. The fn does NOT use --force or --force-with-lease.
#}}}***********************************************************

@setup {
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    cpFile="$pluginDir/autoload/zsh-gacp-CommitAndPush"
}

@test 'CommitAndPush rejects empty message before any git invocation' {
    # Pin: the empty-arg guard fires before zpwrIsGitDir runs, so a
    # caller passing "" gets the error message without touching git
    # state. Pin both the guard form and the early return.
    grep -qE 'if \[\[ -z "\$1" \]\]; then' "$cpFile"
    local guard=$?
    awk '/if \[\[ -z "\$1" \]\]; then/,/^[[:space:]]+fi/' "$cpFile" | grep -qE '^[[:space:]]+return 1'
    local ret=$?
    assert $(( guard + ret )) equals 0
}

@test 'sequence: pull --rebase then add then commit then push (in that order)' {
    # Pin: the order of git invocations on the happy path is fixed.
    # Re-ordering (e.g. push before commit) would either fail loudly
    # or push stale state. Verify line order via grep -n.
    local pull_line add_line commit_line push_line
    pull_line=$(grep -nE 'git pull --rebase' "$cpFile" | head -1 | cut -d: -f1)
    add_line=$(grep -nE 'git add \.' "$cpFile" | head -1 | cut -d: -f1)
    commit_line=$(grep -nE 'git commit -m "\$1"' "$cpFile" | head -1 | cut -d: -f1)
    push_line=$(grep -nE 'git push$' "$cpFile" | head -1 | cut -d: -f1)
    [[ -n "$pull_line" && -n "$add_line" && -n "$commit_line" && -n "$push_line" ]]
    local ok=$?
    [[ "$pull_line" -lt "$add_line" ]] && \
    [[ "$add_line" -lt "$commit_line" ]] && \
    [[ "$commit_line" -lt "$push_line" ]]
    local order=$?
    assert $(( ok + order )) equals 0
}

@test 'push is plain `git push` with NO --force / --force-with-lease' {
    # Pin: the canonical zsh-gacp-CommitAndPush push is a bare `git push`.
    # Adding --force here would silently destroy server-side history on
    # rebase failures; --force-with-lease is safer but still surprising
    # for an "acp" muscle-memory workflow. Pin absence of both flags on
    # any line in this function file.
    ! grep -qE 'git push.*--force' "$cpFile"
    assert $? equals 0
}

@test 'pull-rebase and push BOTH gated on `[[ -n $remotes ]]` (remote-aware)' {
    # Pin: a local-only repo (no remotes configured) must skip pull and
    # push so the function still works as a local commit shortcut.
    # Verify two `if [[ -n $remotes ]]` blocks exist.
    local count
    count=$(grep -cE 'if \[\[ -n \$remotes \]\]; then' "$cpFile")
    assert "$count" same_as '2'
}

@test 'blacklist loop iterates ZSH_GACP_BLACKLISTED_DIRECTORIES array' {
    # Pin: a user CAN exclude specific directories via the env array.
    # The loop variable and comparison `$currentDir == $dir` must
    # remain — renaming either would silently drop the opt-out feature.
    grep -qE 'for dir in "\$\{ZSH_GACP_BLACKLISTED_DIRECTORIES\[@\]\}"' "$cpFile"
    local has_loop=$?
    grep -qE 'if \[\[ "\$currentDir" == "\$dir" \]\]' "$cpFile"
    local has_check=$?
    assert $(( has_loop + has_check )) equals 0
}
