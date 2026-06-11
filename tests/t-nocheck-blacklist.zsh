#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: zsh-git-acp — NoCheck blacklist-variable divergence.
#####          The Ctrl-S "fire-and-forget" widget zsh-gacp-NoCheck
#####          reads its opt-out array from a DIFFERENT variable name
#####          than the documented one and the other two consumers.
#####          README.md / docs say $ZSH_GACP_BLACKLISTED_DIRECTORIES
#####          protects "both widgets"; NoCheck reads the un-prefixed
#####          $GACP_BLACKLISTED_DIRECTORIES, so the documented opt-out
#####          silently fails on the fast path.
#}}}***********************************************************

@setup {
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    autoloadDir="$pluginDir/autoload"
    noCheckFile="$autoloadDir/zsh-gacp-NoCheck"
    checkDiffFile="$autoloadDir/zsh-gacp-CheckDiff"
    cpFile="$autoloadDir/zsh-gacp-CommitAndPush"
}

@test 'BUG-PIN: NoCheck reads GACP_ (un-prefixed), NOT documented ZSH_GACP_' {
    # BUG: autoload/zsh-gacp-NoCheck line 11 iterates
    #   for dir in "${GACP_BLACKLISTED_DIRECTORIES[@]}"
    # but README.md, docs/index.html and docs/report.html all document
    #   export ZSH_GACP_BLACKLISTED_DIRECTORIES=(...)
    # as the variable that protects BOTH widgets. The ZSH_ prefix is
    # missing only here, so a user who sets the documented variable gets
    # NO blacklist protection on the Ctrl-S (no-check) commit-and-push
    # path — the exact fast path where an accidental push is most likely.
    # The two correct consumers use the prefixed name; only NoCheck drifts.
    #
    # This pins the CURRENT BROKEN state. A real fix (rename to
    # ZSH_GACP_BLACKLISTED_DIRECTORIES) flips both asserts below.
    grep -qE 'for dir in "\$\{GACP_BLACKLISTED_DIRECTORIES\[@\]\}"' "$noCheckFile"
    assert $? equals 0
    # And it must NOT (yet) read the prefixed name anywhere in the file.
    run grep -qE 'ZSH_GACP_BLACKLISTED_DIRECTORIES' "$noCheckFile"
    assert $state equals 1
}

@test 'the two NON-buggy widgets agree on ZSH_GACP_BLACKLISTED_DIRECTORIES' {
    # Consistency contract that NoCheck violates: CheckDiff (the Ctrl-F
    # Ctrl-S widget) and CommitAndPush both read the prefixed, documented
    # variable. Pinning their agreement makes the NoCheck divergence above
    # provably a one-off drift, not the intended name. If a future edit
    # renamed THESE to the un-prefixed form, the docs would still be wrong
    # but at least consistent — this guards the documented name as canon.
    grep -qE 'for dir in "\$\{ZSH_GACP_BLACKLISTED_DIRECTORIES\[@\]\}"' "$checkDiffFile"
    local cd_ok=$?
    grep -qE 'for dir in "\$\{ZSH_GACP_BLACKLISTED_DIRECTORIES\[@\]\}"' "$cpFile"
    local cp_ok=$?
    assert $(( cd_ok + cp_ok )) equals 0
}
