#!/bin/bash

backspace() {
	local num=$1
    for ((i=0; i<num; i++)); do
        tput cub 1
    done
}

#Trash
printf "\033[91m[trash]"
/bin/rm -rf "$HOME"/.Trash/* &>/dev/null
backspace 7
printf "\033[92m[trash] "

#General Caches files
printf "\033[91m[caches]"
/bin/rm -rf "$HOME"/Library/Caches/* &>/dev/null
backspace 8
printf "\033[92m[caches] "

# slack, VSCode, Discord and Chrome Caches
printf "\033[91m[slack]"
/bin/rm -rf "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/* &>/dev/null
/bin/rm -rf "$HOME"/Library/Application\ Support/Slack/Cache/* &>/dev/null
backspace 7
printf "\033[92m[slack] "

# chrome
printf "\033[91m[chrome]"
/bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/* &>/dev/null
/bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/* &>/dev/null
/bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/* &>/dev/null
backspace 8
printf "\033[92m[chrome] "

# vs_code
printf "\033[91m[vscode]"
/bin/rm -rf "$HOME"/Library/Application\ Support/Code/Cache/* &>/dev/null
/bin/rm -rf "$HOME"/Library/Application\ Support/Code/CachedData/* &>/dev/null
/bin/rm -rf "$HOME"/Library/Application\ Support/Code/Crashpad/completed/* &>/dev/null
backspace 8
printf "\033[92m[vscode] "

# .DS_Store files
printf "\033[91m[.DS_Store]"
find "$HOME"/Desktop -name .DS_Store -depth -exec /bin/rm {} \; &>/dev/null
#find "$HOME"/Documents -name .DS_Store -depth -exec /bin/rm {} \; &>/dev/null
backspace 11
printf "\033[92m[.DS_Store] "

# tmp downloaded files with browsers
printf "\033[91m[tmp files]"
/bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System &>/dev/null
/bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System &>/dev/null
backspace 11
printf "\033[92m[tmp files] "

#Keychain icloud sub directories
printf "\033[91m[Keychain]"
KEYCHAIN_DIR="$HOME/Library/Keychains"
if [[ -d "$KEYCHAIN_DIR" ]]; then
	for item in "$KEYCHAIN_DIR"/*; do
		[[ -d "$item" ]] && rm -rf "$item"
	done
	# Delete standby keychain-db (optional)
	# for FILE in "$KEYCHAIN_DIR"/login.keychain-db.sb-*; do
	# 	[[ -e "$FILE" ]] && rm "$FILE"
	# done

fi
backspace 10
printf "\033[92m[Keychain] "

echo -e "\033[0m"
