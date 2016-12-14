#!/bin/bash

BREW="/usr/local/bin/brew"
TERMINAL_NOTIFIER="/usr/local/bin/terminal-notifier"

$BREW update > /dev/null 2>&1

outdated=$($BREW outdated --quiet)
pinned=$($BREW list --pinned)
updatable=$(comm -1 -3 <(echo "$pinned") <(echo "$outdated"))

if [ -n "$updatable" ] && [ -e "$TERMINAL_NOTIFIER" ]; then
    $TERMINAL_NOTIFIER -sender com.apple.Terminal \
        -title "Homebrew Updates Available" \
        -subtitle "The following formulae are outdated:" \
        -message "$updatable" \
        -appIcon homebrew_icon.png
fi
