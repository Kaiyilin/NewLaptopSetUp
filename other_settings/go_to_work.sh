#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title GoToWork
# @raycast.mode compact
# @raycast.icon 🤖
# @raycast.description It's made for me as the shortcut to get to work
# @raycast.author kaiyilin
# @raycast.authorURL https://raycast.com/kaiyilin

echo "Good Day!"

source "$HOME/.config/personal_config/workapps.sh"

for app in "${GO_APPS[@]}"; do
    open -a "$app"
done