#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title ClockOff
# @raycast.mode compact
# @raycast.icon 🎉
# @raycast.description To quit all the working apps.
# @raycast.author kaiyilin
# @raycast.authorURL https://raycast.com/kaiyilin

echo "Have a good day!"

source "$HOME/.config/personal_config/workapps.sh"

for app in "${CLOCK_APPS[@]}"; do
    osascript -e "if application \"$app\" is running then tell application \"$app\" to quit" 2>/dev/null
done

open raycast://confetti